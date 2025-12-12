import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  String error = "";
  bool loading = false;

  Future<File> _getUsuariosFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/usuarios.json');
  }

  Future<void> registrar() async {
    setState(() {
      loading = true;
      error = "";
    });

    try {
      final file = await _getUsuariosFile();

      List usuarios = [];

      if (await file.exists()) {
        final data = jsonDecode(await file.readAsString());
        usuarios = data["usuarios"] ?? [];
      }

      final existe =
          usuarios.any((u) => u["email"] == _email.text.trim());

      if (existe) {
        setState(() => error = "El correo ya está registrado.");
        return;
      }

      usuarios.add({
        "email": _email.text.trim(),
        "password": _password.text.trim(),
      });

      await file.writeAsString(jsonEncode({"usuarios": usuarios}));

      Navigator.pop(context);
    } catch (e) {
      setState(() => error = "Error al registrar: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear cuenta")),
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
              onPressed: loading ? null : registrar,
              child: Text(loading ? "Guardando..." : "Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}

