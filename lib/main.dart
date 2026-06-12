import 'package:flutter/material.dart';
import 'view/theme/theme.dart';
import 'view/screens/permissions_screen.dart';
import 'view/screens/welcome_screen.dart';
import 'view/screens/pin_login_screen.dart';
import 'view/screens/password_login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/permissions': (context) => PermissionsScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/pinlogin': (context) => PinLoginScreen(),
        '/passwordlogin': (context) => PasswordLoginScreen(),
      },
      home: PasswordLoginScreen(),
    );
  }
}
