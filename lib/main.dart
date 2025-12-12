import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'screens/bienvenida_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa datos locales
  await initializeAppData();

  runApp(const BibliotecaApp());
}

// Inicializar JSON locales al arrancar la app
Future<void> initializeAppData() async {
  try {
    final directory = await getApplicationDocumentsDirectory();

    final reportesFile = File('${directory.path}/reportes.json');
    final librosFile = File('${directory.path}/libros.json');
    final reservasFile = File('${directory.path}/reservas.json');

    if (!await reportesFile.exists()) {
      final reportesIniciales = {
        'reportes': [],
        'fecha_creacion': DateTime.now().toIso8601String(),
      };
      await reportesFile.writeAsString(jsonEncode(reportesIniciales));
    }

    if (!await librosFile.exists()) {
      final librosIniciales = {
        'libros': [
          {
            'id': '1',
            'titulo': 'Cien años de soledad',
            'autor': 'Gabriel García Márquez',
            'isbn': '978-0307474728',
            'disponible': true
          },
          {
            'id': '2',
            'titulo': 'Don Quijote de la Mancha',
            'autor': 'Miguel de Cervantes',
            'isbn': '978-8424936464',
            'disponible': true
          }
        ],
        'fecha_creacion': DateTime.now().toIso8601String(),
      };
      await librosFile.writeAsString(jsonEncode(librosIniciales));
    }

    if (!await reservasFile.exists()) {
      final reservasIniciales = {
        'reservas': [],
        'fecha_creacion': DateTime.now().toIso8601String(),
      };
      await reservasFile.writeAsString(jsonEncode(reservasIniciales));
    }
  } catch (e) {
    print('Error al inicializar datos: $e');
  }
}

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca App',
      debugShowCheckedModeBanner: false,
      theme: _buildDarkTheme(),
      home: BienvenidaScreen(),   // ← CORREGIDO (sin const)
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6B4CE6),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121218),
    );
  }
}
