import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/app_background.dart';
import '../components/custom_button.dart';
import '../models/user_session.dart';
import '../routes/app_routes.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({
    super.key,
    this.email = '',
  });

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  int _secondsRemaining = 45;
  Timer? _timer;
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _secondsRemaining = 45);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyCode() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      Navigator.pushNamed(context, AppRoutes.newPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailToShow = widget.email.isNotEmpty ? widget.email : UserSession.currentUserEmail;
    final canResend = _secondsRemaining == 0;
    final isComplete = _controllers.every((c) => c.text.isNotEmpty);

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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.shield_outlined, size: 60, color: Colors.purple),
                const SizedBox(height: 16),
                const Text('Verifica tu correo', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'Escribe el código de 4 dígitos que enviamos a\n$emailToShow',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onChanged: (val) {
                          _onChanged(val, index);
                          setState(() {});
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: canResend ? _startTimer : null,
                    child: Text(
                      canResend
                          ? 'Reenviar código'
                          : '¿No te llegó? Reenviar código en 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                      style: TextStyle(color: canResend ? Colors.purple : Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Siguiente',
                  onPressed: isComplete ? _verifyCode : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}