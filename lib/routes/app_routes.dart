import 'package:flutter/material.dart';
import '../models/user_session.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/verification_code_screen.dart';
import '../screens/new_password_screen.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verificationCode = '/verification-code';
  static const String newPassword = '/new-password';
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      verificationCode: (context) {
        final email = ModalRoute.of(context)?.settings.arguments as String? ?? UserSession.currentUserEmail;
        return VerificationCodeScreen(email: email);
      },
      newPassword: (context) => const NewPasswordScreen(),
      home: (context) {
        final email = ModalRoute.of(context)?.settings.arguments as String? ?? UserSession.currentUserEmail;
        return HomeScreen(userEmail: email);
      },
    };
  }
}