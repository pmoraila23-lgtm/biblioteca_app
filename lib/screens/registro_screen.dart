import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class RegistroScreen extends StatefulWidget { // ← CAMBIADO: era RegisterScreen
  const RegistroScreen({super.key}); // ← CAMBIADO

  @override
  State<RegistroScreen> createState() => _RegistroScreenState(); // ← CAMBIADO
}

class _RegistroScreenState extends State<RegistroScreen> { // ← CAMBIADO
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool loading = false;
  String error = '';

  Future<void> register() async {
    setState(() {
      loading = true;
      error = '';
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => error = e.message ?? 'Error desconocido');
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear cuenta")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: "Correo"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),
            const SizedBox(height: 20),
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: loading ? null : register,
              child: Text(loading ? "Cargando..." : "Registrarme"),
            ),
          ],
        ),
      ),
    );
  }
}
