import 'package:flutter/material.dart';
import '../components/app_background.dart';
import '../components/custom_button.dart';
import '../components/custom_input.dart';
import '../routes/app_routes.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _has8Chars = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateRequirements);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updateRequirements);
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _updateRequirements() {
    final pass = _passwordController.text;
    setState(() {
      _has8Chars = pass.length >= 8;
      _hasUppercase = pass.contains(RegExp(r'[A-Z]'));
      _hasNumber = pass.contains(RegExp(r'[0-9]'));
    });
  }

  void _submit() {
    final passwordsMatch = _passwordController.text == _confirmController.text;
    if (_has8Chars && _hasUppercase && _hasNumber && passwordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña actualizada con éxito')),
      );
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    } else if (!passwordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final allValid = _has8Chars && _hasUppercase && _hasNumber;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('✓ Código verificado', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Icon(Icons.lock_outline, size: 60, color: Colors.purple),
                const SizedBox(height: 16),
                const Text('Crea una nueva contraseña', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Tu nueva contraseña debe ser diferente a las que usaste antes.', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 30),
                CustomInput(
                  label: 'Nueva contraseña',
                  hintText: '••••••••',
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),
                CustomInput(
                  label: 'Confirmar contraseña',
                  hintText: '••••••••',
                  isPassword: true,
                  controller: _confirmController,
                ),
                const SizedBox(height: 20),
                _RequirementText(text: 'Mínimo 8 caracteres', isValid: _has8Chars),
                _RequirementText(text: 'Al menos una mayúscula', isValid: _hasUppercase),
                _RequirementText(text: 'Al menos un número', isValid: _hasNumber),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Restablecer contraseña',
                  onPressed: allValid ? _submit : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RequirementText extends StatelessWidget {
  final String text;
  final bool isValid;
  const _RequirementText({required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(isValid ? Icons.check : Icons.close, color: isValid ? Colors.green : Colors.red, size: 16),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: isValid ? Colors.green : Colors.grey)),
      ],
    );
  }
}