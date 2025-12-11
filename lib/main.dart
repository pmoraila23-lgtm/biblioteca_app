import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/bienvenida_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase (captura errores para diagnóstico)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, st) {
    // Imprime el error y la traza; no detiene la app para facilitar depuración
    // (si Firebase es crítico, puedes rethrow o salir aquí)
    // ignore: avoid_print
    print('Error inicializando Firebase: $e');
    // ignore: avoid_print
    print(st);
  }

  await initializeAppData();
  runApp(const BibliotecaApp());
}

// Función para inicializar datos JSON al inicio
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
      home: const BienvenidaScreen(),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Colores base (fromSeed ayuda a mantener coherencia)
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6B4CE6),
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(0xFF6B4CE6),
        secondary: const Color(0xFF03DAC6),
        tertiary: const Color(0xFFFF6B6B),
        surface: const Color(0xFF1E1E2E),
        error: const Color(0xFFCF6679),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: const Color(0xFFE0E0E0),
      ),

      scaffoldBackgroundColor: const Color(0xFF121218),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E2E),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      // TextFields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A3C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3A3A4C), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6B4CE6), width: 2),
        ),
      ),

      // Elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4CE6),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Cards (usar CardThemeData para compatibilidad según SDK)
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E2E),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Dialogs
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Switch: usar MaterialStateProperty/MaterialState
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return const Color(0xFF03DAC6);
          return const Color(0xFF707070);
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return const Color(0xFF03DAC6).withOpacity(0.5);
          return const Color(0xFF3A3A4C);
        }),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF6B4CE6),
        foregroundColor: Colors.white,
      ),

      // SnackBar
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF2A2A3C),
        contentTextStyle: TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
