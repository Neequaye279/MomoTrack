import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;
  final _secureStorage = const FlutterSecureStorage();

  String _hashLocalPin(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  Future<void> _storeLocalCredentials({
    required String email,
    required String password,
    required String pin,
  }) async {
    final pinHash = _hashLocalPin(pin);
    await _secureStorage.write(key: 'local_email', value: email);
    await _secureStorage.write(key: 'local_password', value: password);
    await _secureStorage.write(key: 'local_pin_hash', value: pinHash);
  }

  // Used by password-flow signup/login, where there's no PIN involved,
  // so credentials are stored without a pin hash.
  Future<void> storeCredentialsForBiometricLogin({
    required String email,
    required String password,
  }) async {
    await _secureStorage.write(key: 'local_email', value: email);
    await _secureStorage.write(key: 'local_password', value: password);
  }

  Future<bool> hasLocalPinCredentials() async {
    final email = await _secureStorage.read(key: 'local_email');
    final password = await _secureStorage.read(key: 'local_password');
    final pinHash = await _secureStorage.read(key: 'local_pin_hash');
    return email != null && password != null && pinHash != null;
  }

  Future<AuthResponse> signInWithLocalPin(String pin) async {
    final storedHash = await _secureStorage.read(key: 'local_pin_hash');
    if (storedHash == null) throw Exception('No PIN set up on this device');

    final enteredHash = _hashLocalPin(pin);
    if (enteredHash != storedHash) throw Exception('Incorrect PIN');

    final email = await _secureStorage.read(key: 'local_email');
    final password = await _secureStorage.read(key: 'local_password');
    if (email == null || password == null) {
      throw Exception('No account linked to this device');
    }

    return await signIn(email: email, password: password);
  }

  Future<void> clearLocalPinCredentials() async {
    await _secureStorage.delete(key: 'local_email');
    await _secureStorage.delete(key: 'local_password');
    await _secureStorage.delete(key: 'local_pin_hash');
    await _secureStorage.delete(key: 'biometrics_enabled_local');
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) {
    return _client.auth.signUp(password: password, email: email);
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<UserResponse> attachPhone({required String phone}) {
    return _client.auth.updateUser(UserAttributes(phone: phone));
  }

  Future<AuthResponse> verifyPhoneOtp({
    required String phone,
    required String token,
  }) {
    return _client.auth.verifyOTP(
      type: OtpType.phoneChange,
      token: token,
      phone: phone,
    );
  }

  Future<void> signOut() {
    return _client.auth.signOut();
  }

  Future<String> requestOtp(String phoneNumber) async {
    final code = (100000 + Random().nextInt(900000)).toString();
    final expiresAt = DateTime.now().add(const Duration(minutes: 5));

    await _client
        .from('otp_codes')
        .insert({
          'phone_number': phoneNumber,
          'code': code,
          'expires_at': expiresAt.toIso8601String(),
        })
        .timeout(const Duration(seconds: 10));

    debugPrint('MOCK OTP for $phoneNumber: $code');
    return code;
  }

  Future<bool> verifyOtp(String phoneNumber, String enteredCode) async {
    final result = await _client
        .rpc(
          'verify_otp',
          params: {'p_phone': phoneNumber, 'p_code': enteredCode},
        )
        .timeout(const Duration(seconds: 10));

    return result == true;
  }

  String _hashPin(String pin) {
    final userId = _client.auth.currentUser?.id ?? '';
    final bytes = utf8.encode('$pin:$userId');
    return sha256.convert(bytes).toString();
  }

  Future<void> setPin(String pin) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('No authenticated user');

    final hashedPin = _hashPin(pin);

    await _client
        .from('user_pins')
        .upsert({'user_id': userId, 'pin_hash': hashedPin})
        .timeout(const Duration(seconds: 10));
  }

  Future<bool> verifyPin(String pin) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return false;

    final hashedPin = _hashPin(pin);

    final result = await _client
        .from('user_pins')
        .select()
        .eq('user_id', userId)
        .eq('pin_hash', hashedPin)
        .maybeSingle()
        .timeout(const Duration(seconds: 10));

    return result != null;
  }

  String _generateSecurePassword() {
    final rand = Random.secure();
    final bytes = List<int>.generate(32, (_) => rand.nextInt(256));
    return base64UrlEncode(bytes);
  }

  Future<AuthResponse> signUpWithPin({
    required String email,
    required String pin,
  }) async {
    final password = _generateSecurePassword();
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    await _storeLocalCredentials(email: email, password: password, pin: pin);
    return response;
  }

  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> canUseBiometrics() async {
    final isSupported = await _localAuth.isDeviceSupported();
    final canCheck = await _localAuth.canCheckBiometrics;
    return isSupported && canCheck;
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Confirm your identity to enable biometric login',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } on LocalAuthException catch (e) {
      debugPrint('Biometric auth failed: ${e.code}');
      return false;
    }
  }

  // Supabase-stored flag — requires a session, used for cross-device settings sync
  Future<void> setBiometricsEnabled(bool enabled) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client
        .from('user_settings')
        .upsert({'user_id': userId, 'biometrics_enabled': enabled})
        .timeout(const Duration(seconds: 10));
  }

  Future<bool> getBiometricsEnabled() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return false;

    final result = await _client
        .from('user_settings')
        .select('biometrics_enabled')
        .eq('user_id', userId)
        .maybeSingle()
        .timeout(const Duration(seconds: 10));

    return result?['biometrics_enabled'] == true;
  }

  // Local-only flag — no session required, checkable from the login screen
  Future<void> setBiometricsEnabledLocal(bool enabled) async {
    await _secureStorage.write(
      key: 'biometrics_enabled_local',
      value: enabled.toString(),
    );
  }

  Future<bool> getBiometricsEnabledLocal() async {
    final value = await _secureStorage.read(key: 'biometrics_enabled_local');
    return value == 'true';
  }

  Future<AuthResponse> signInWithBiometrics() async {
    final success = await authenticateWithBiometrics();
    if (!success) throw Exception('Biometric authentication failed');

    final email = await _secureStorage.read(key: 'local_email');
    final password = await _secureStorage.read(key: 'local_password');
    if (email == null || password == null) {
      throw Exception('No credentials stored for biometric login');
    }

    return await signIn(email: email, password: password);
  }

  Future<bool> hasSeenPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('has_seen_permissions') ?? false;
  }

  Future<void> markPermissionsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_permissions', true);
  }

  Session? get getCurrentSession => _client.auth.currentSession;
  User? get getCurrentUser => _client.auth.currentUser;
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
