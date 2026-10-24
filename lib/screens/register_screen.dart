import 'package:flutter/material.dart';
import '../components/app_background.dart';
import '../components/custom_button.dart';
import '../components/custom_input.dart';
import '../models/user_session.dart';
import '../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptedTerms = false;

  void _submitRegister() {
    if (_formKey.currentState!.validate() && _acceptedTerms) {
      UserSession.currentUserEmail = _emailController.text.trim();
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
        arguments: UserSession.currentUserEmail,
      );
    } else if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes aceptar los términos y condiciones')),
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
          onPressed: () => Navigator.pop(context), // Botón atrás
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Crea tu cuenta', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const Text('Completa tus datos para empezar', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  CustomInput(
                    label: 'Nombre completo',
                    hintText: 'Juan Pérez',
                    controller: _nameController,
                    validator: (val) => val == null || val.trim().isEmpty ? 'Campo obligatorio' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Correo electrónico',
                    hintText: 'tu@correo.com',
                    controller: _emailController,
                    validator: (val) => val == null || !val.contains('@') ? 'Correo inválido' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Contraseña',
                    hintText: 'Mínimo 8 caracteres',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (val) => val!.length < 8 ? 'Mínimo 8 caracteres' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Confirmar contraseña',
                    hintText: 'Repite tu contraseña',
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (val) => val != _passwordController.text ? 'Las contraseñas no coinciden' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptedTerms,
                        activeColor: Colors.purple,
                        onChanged: (val) => setState(() => _acceptedTerms = val!),
                      ),
                      const Expanded(
                        child: Text('Acepto los Términos y condiciones y la Política de privacidad', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Crear cuenta',
                    onPressed: _acceptedTerms ? _submitRegister : null,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text('¿Ya tienes cuenta? Inicia sesión', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}