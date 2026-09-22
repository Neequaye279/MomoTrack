import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'view/theme/theme.dart';
import 'view/screens/permissions_screen.dart';
import 'view/screens/welcome_screen.dart';
import 'view/screens/login_screen.dart/password_login_screen.dart';
import 'view/screens/signup_screen/biometrics.dart';
import 'view/screens/signup_screen/create_account.dart';
import 'view/screens/signup_screen/create_password.dart';
import 'view/screens/signup_screen/verfication.dart';
import 'view/screens/splash_screen.dart';
import 'view/screens/mainapp_screens.dart/history.dart';
import 'view/screens/mainapp_screens.dart/home.dart';
import 'view/screens/mainapp_screens.dart/reports.dart';
import 'view/screens/mainapp_screens.dart/settings.dart';
import 'view/screens/mainapp_screens.dart/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jwwwwudkhwxlxwwllgte.supabase.co',
    publishableKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3d3d3dWRraHd4bHh3d2xsZ3RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU3NDk1NDcsImV4cCI6MjEwMTMyNTU0N30.gvc44zVzGuCq8HhiFo3KT1LlQ3-8svQB3DcDZHREqE8',
  );
  runApp(const ProviderScope(child: MyApp()));
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorObservers: [routeObserver],
      title: "MoMo Track",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightMode,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F4F8),
      ),
      darkTheme: ThemeData(
        colorScheme: darkMode,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF080A0F),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/permissions': (context) => PermissionsScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/passwordlogin': (context) => PasswordLoginScreen(),
        '/biometrics': (context) => Biometrics(),
        '/createaccount': (context) => CreateAccount(),
        '/createpassword': (context) => CreatePassword(),
        '/verification': (context) => Verfication(),
        '/home': (context) => Home(),
        '/history': (context) => History(),
        '/reports': (context) => Reports(),
        '/settings': (context) => Settings(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
