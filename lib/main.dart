import 'package:flutter/material.dart';
import 'models/user_session.dart';
import 'routes/app_routes.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/verification_code_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Auth Flow',
      initialRoute: AppRoutes.login,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case AppRoutes.register:
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case AppRoutes.forgotPassword:
            return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
          case AppRoutes.verificationCode:
            final email = settings.arguments as String? ?? UserSession.currentUserEmail;
            return MaterialPageRoute(
              builder: (_) => VerificationCodeScreen(email: email),
            );
          case AppRoutes.newPassword:
            return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
          case AppRoutes.home:
            final email = settings.arguments as String? ?? UserSession.currentUserEmail;
            return MaterialPageRoute(
              builder: (_) => HomeScreen(userEmail: email),
            );
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}