import 'package:flutter/material.dart';
import 'view/theme/theme.dart';
import 'view/screens/permissions_screen.dart';
import 'view/screens/welcome_screen.dart';
import 'view/screens/login_screen.dart/pin_login_screen.dart';
import 'view/screens/login_screen.dart/password_login_screen.dart';
import 'view/screens/signup_screen/biometrics.dart';
import 'view/screens/signup_screen/create_account.dart';
import 'view/screens/signup_screen/create_password.dart';
import 'view/screens/signup_screen/create_pin.dart';
import 'view/screens/signup_screen/verfication.dart';
import 'view/screens/splash_screen.dart';
import 'view/screens/mainapp_screens.dart/history.dart';
import 'view/screens/mainapp_screens.dart/home.dart';
import 'view/screens/mainapp_screens.dart/reports.dart';
import 'view/screens/mainapp_screens.dart/settings.dart';
import 'view/screens/mainapp_screens.dart/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      //initialRoute: '/',
      home: MainScreen(),
      //routes: {
      // '/': (context) => SplashScreen(),
      // '/permissions': (context) => PermissionsScreen(),
      // '/welcome': (context) => WelcomeScreen(),
      // '/pinlogin': (context) => PinLoginScreen(),
      // '/passwordlogin': (context) => PasswordLoginScreen(),
      // '/biometrics': (context) => Biometrics(),
      // '/createaccount': (context) => CreateAccount(),
      // '/createpassword': (context) => CreatePassword(),
      // '/createpin': (context) => CreatePin(),
      // '/verification': (context) => Verfication(),
      // '/home': (context) => Home(),
      // '/history': (context) => History(),
      // '/reports': (context) => Reports(),
      // '/settings': (context) => Settings(),
      //'/main': (context) => MainScreen(),
      //},
    );
  }
}
