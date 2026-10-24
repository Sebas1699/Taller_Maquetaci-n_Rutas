import 'package:flutter/material.dart';
import '../components/app_background.dart';
import '../components/custom_button.dart';
import '../components/custom_input.dart';
import '../routes/app_routes.dart';
import '../models/user_session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      UserSession.currentUserEmail = _emailController.text.trim();
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
        arguments: UserSession.currentUserEmail,
      );
    }
  }

  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_rounded, size: 60, color: Colors.purple),
                    const SizedBox(height: 16),
                    const Text(
                      'Bienvenido de nuevo',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Inicia sesión para continuar',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    CustomInput(
                      label: 'Correo electrónico',
                      hintText: 'tu@correo.com',
                      controller: _emailController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Campo obligatorio';
                        if (!val.contains('@')) return 'Ingresa un correo válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomInput(
                      label: 'Contraseña',
                      hintText: '••••••••',
                      isPassword: true,
                      controller: _passwordController,
                      validator: (val) => val == null || val.isEmpty ? 'Campo obligatorio' : null,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                        child: const Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    CustomButton(
                      text: 'Iniciar sesión',
                      onPressed: _submitLogin,
                    ),

                    const SizedBox(height: 24),
                    const Text('o continúa con', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Google',
                            isSecondary: true,
                            onPressed: () => _showSnackbar('Funcionalidad no disponible'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: 'Apple',
                            isSecondary: true,
                            onPressed: () => _showSnackbar('Funcionalidad no disponible'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿No tienes cuenta? '),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                          child: const Text(
                            'Regístrate',
                            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}