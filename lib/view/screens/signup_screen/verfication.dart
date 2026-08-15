import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:momo_track/view/widgets/progress_stepper.dart';
import 'package:momo_track/view/widgets/screen_button.dart';
import 'package:momo_track/viewModel/otp_provider.dart';
import 'package:momo_track/viewModel/signup_proivder.dart';

class Verfication extends ConsumerStatefulWidget {
  const Verfication({super.key});

  @override
  ConsumerState<Verfication> createState() => _VerficationState();
}

class _VerficationState extends ConsumerState<Verfication> {
  final TextEditingController _codeController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 300; // 5 minutes, matches otp expiry

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _sendCode());
  }

  void _sendCode() {
    final phone = ref.read(signupProvider).phoneNumber;
    ref.read(otpProvider.notifier).sendOtp(phone);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 300);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String get _formattedTime {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final otpState = ref.watch(otpProvider);
    final phone = ref.watch(signupProvider).phoneNumber;
    final isVerifying = otpState.status == OtpStatus.verifying;
    final canResend = _secondsRemaining <= 0;

    ref.listen(otpProvider, (previous, next) {
      if (next.status == OtpStatus.verified) {
        Navigator.pushNamed(context, '/createpin');
      } else if (next.status == OtpStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceBright,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.05),
                          width: 1.0,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(LucideIcons.chevronLeft),
                        color: Color(0xFF8B8D98),
                        iconSize: 18.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(child: ProgressStepper(currentStep: 1)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "Verify your number",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 15.0, letterSpacing: 0.5),
                    children: [
                      TextSpan(
                        text: "Code sent to",
                        style: TextStyle(color: Color(0xFF8B8D98)),
                      ),
                      TextSpan(
                        text: " $phone",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                if (otpState.mockCode != null)
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.015),
                    child: Text(
                      "Dev mode — your code is ${otpState.mockCode}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                SizedBox(height: screenHeight * 0.05),
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xFF8B8D98)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                    counterText: "",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      canResend ? "Code expired" : "Expires in $_formattedTime",
                      style: TextStyle(
                        color: Color(0xFF8B8D98),
                        fontSize: 13.0,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: canResend ? _sendCode : null,
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          color: canResend
                              ? Theme.of(context).colorScheme.primary
                              : Color(0xFF8B8D98),
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                ScreenButton(
                  buttonText: isVerifying ? "Verifying..." : "Continue",
                  background: Theme.of(context).colorScheme.primary,
                  foreground: Theme.of(context).colorScheme.onPrimary,
                  onPressed: isVerifying
                      ? () {}
                      : () {
                          if (_codeController.text.length != 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter the 6-digit code'),
                              ),
                            );
                            return;
                          }
                          ref
                              .read(otpProvider.notifier)
                              .verify(_codeController.text);
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
