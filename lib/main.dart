import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'screens/bienvenida_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

    // Crear archivo de reportes si no existe
    if (!await reportesFile.exists()) {
      final reportesIniciales = {
        'reportes': [],
        'fecha_creacion': DateTime.now().toIso8601String(),
      };
      await reportesFile.writeAsString(jsonEncode(reportesIniciales));
      print('✓ Archivo reportes.json creado');
    }

    // Crear archivo de libros si no existe
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
      print('✓ Archivo libros.json creado');
    }

    // Crear archivo de reservas si no existe
    if (!await reservasFile.exists()) {
      final reservasIniciales = {
        'reservas': [],
        'fecha_creacion': DateTime.now().toIso8601String(),
      };
      await reservasFile.writeAsString(jsonEncode(reservasIniciales));
      print('✓ Archivo reservas.json creado');
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

  // Tema oscuro personalizado
  ThemeData _buildDarkTheme() {
    var themeData = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Esquema de colores principal
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF6B4CE6), // Púrpura vibrante
        secondary: Color(0xFF03DAC6), // Verde azulado
        tertiary: Color(0xFFFF6B6B), // Rojo coral
        surface: Color(0xFF1E1E2E), // Fondo principal
        error: Color(0xFFCF6679),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Color(0xFFE0E0E0),
      ),

      // Scaffold
      scaffoldBackgroundColor: const Color(0xFF121218),

      // AppBar personalizado
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

      // Cards personalizadas
      cardTheme: CardThemeData(
  color: const Color(0xFF1E1E2E),
  elevation: 4,
  shadowColor: Colors.black.withOpacity(0.3),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
),
      // Botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4CE6),
          foregroundColor: Colors.white,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Botones de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF6B4CE6),
        ),
      ),

      // Campos de texto
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFCF6679), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFCF6679), width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFFB0B0B0)),
        hintStyle: const TextStyle(color: Color(0xFF707070)),
        errorStyle: const TextStyle(color: Color(0xFFCF6679)),
      ),

      // Dividers
      dividerTheme: const DividerThemeData(
        color: Color(0xFF2A2A3C),
        thickness: 1,
      ),

      // Iconos
      iconTheme: const IconThemeData(
        color: Color(0xFF6B4CE6),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF03DAC6);
          }
          return const Color(0xFF707070);
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF03DAC6).withOpacity(0.5);
          }
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
    return themeData;
  }
}