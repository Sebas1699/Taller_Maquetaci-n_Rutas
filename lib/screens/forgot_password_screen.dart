import 'package:flutter/material.dart';
import '../components/app_background.dart';
import '../components/custom_button.dart';
import '../components/custom_input.dart';
import '../models/user_session.dart';
import '../routes/app_routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      UserSession.currentUserEmail = _emailController.text.trim();
      Navigator.pushNamed(
        context,
        AppRoutes.verificationCode,
        arguments: UserSession.currentUserEmail,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Botón atrás[cite: 3]
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.mail_outline, size: 60, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text('¿Olvidaste tu contraseña?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Ingresa el correo con el que te registraste y te enviaremos un código de 4 dígitos.', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 30),
                  CustomInput(
                    label: 'Correo electrónico',
                    hintText: 'tu@correo.com',
                    controller: _emailController,
                    validator: (val) => val == null || !val.contains('@') ? 'Correo inválido' : null,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(text: 'Enviar código', onPressed: _submit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}