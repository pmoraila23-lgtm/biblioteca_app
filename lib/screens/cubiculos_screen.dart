import 'package:flutter/material.dart';
import '../widgets/item_card.dart';

class CubiculosScreen extends StatelessWidget {
  final Function(String, String) onReservar;

  const CubiculosScreen({super.key, required this.onReservar});

  @override
  Widget build(BuildContext context) {
    final cubiculos = [
      {'nombre': 'C-101', 'capacidad': 4, 'disponible': true},
      {'nombre': 'C-102', 'capacidad': 4, 'disponible': false},
      {'nombre': 'C-103', 'capacidad': 6, 'disponible': true},
      {'nombre': 'C-201', 'capacidad': 4, 'disponible': true},
      {'nombre': 'C-202', 'capacidad': 8, 'disponible': false},
      {'nombre': 'C-203', 'capacidad': 4, 'disponible': true},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Cubículos')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cubiculos.length,
        itemBuilder: (context, index) {
          final c = cubiculos[index];
          return ItemCard(
            titulo: c['nombre'] as String,
            subtitulo: '${c['capacidad']} personas',
            disponible: c['disponible'] as bool,
            color: Colors.blue,
            onReservar: () {
              onReservar('Cubículo', c['nombre'] as String);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✓ Cubículo reservado'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          );
        },
      ),
    );
  }
}