import 'package:flutter/material.dart';
import '../components/app_background.dart';
import '../components/custom_button.dart';
import '../models/user_session.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final String userEmail;

  const HomeScreen({
    super.key,
    this.userEmail = '',
  });

  @override
  Widget build(BuildContext context) {
    final emailToShow = userEmail.isNotEmpty ? userEmail : UserSession.currentUserEmail;
    UserSession.currentUserEmail = emailToShow;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text('¡Bienvenido!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.mail_outline, color: Colors.purple, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        emailToShow,
                        style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Cerrar sesión',
                  onPressed: () {
                    UserSession.currentUserEmail = '';
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
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