import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'registro_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool loading = false;
  String error = "";

  // Obtener archivo usuarios.json
  Future<File> _getUsuariosFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/usuarios.json');
  }

  Future<void> login() async {
    setState(() {
      loading = true;
      error = "";
    });

    try {
      final file = await _getUsuariosFile();

      if (!await file.exists()) {
        setState(() => error = "No hay usuarios registrados.");
        return;
      }

      final data = jsonDecode(await file.readAsString());
      final usuarios = (data["usuarios"] ?? []) as List;

      // Buscar usuario manualmente (sin usar firstWhere)
      Map<String, dynamic>? user;

      for (var u in usuarios) {
        if (u["email"] == _email.text.trim() &&
            u["password"] == _password.text.trim()) {
          user = Map<String, dynamic>.from(u);
          break;
        }
      }

      if (user == null) {
        setState(() => error = "Correo o contraseña incorrectos");
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      setState(() => error = "Error al iniciar sesión: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: "Correo"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),
            const SizedBox(height: 20),

            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),

            ElevatedButton(
              onPressed: loading ? null : login,
              child: Text(loading ? "Cargando..." : "Entrar"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegistroScreen()),
                );
              },
              child: const Text("Crear cuenta"),
            ),
          ],
        ),
      ),
    );
  }
}
