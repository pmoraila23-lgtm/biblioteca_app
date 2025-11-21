import 'package:flutter/material.dart';
import '../widgets/item_card.dart';

class ComputadorasScreen extends StatelessWidget {
  final Function(String, String) onReservar;

  const ComputadorasScreen({super.key, required this.onReservar});

  @override
  Widget build(BuildContext context) {
    final computadoras = [
      {'nombre': 'PC-01', 'zona': 'Zona A', 'disponible': true},
      {'nombre': 'PC-02', 'zona': 'Zona A', 'disponible': false},
      {'nombre': 'PC-03', 'zona': 'Zona A', 'disponible': true},
      {'nombre': 'PC-04', 'zona': 'Zona B', 'disponible': true},
      {'nombre': 'PC-05', 'zona': 'Zona B', 'disponible': false},
      {'nombre': 'PC-06', 'zona': 'Zona B', 'disponible': true},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Computadoras')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: computadoras.length,
        itemBuilder: (context, index) {
          final c = computadoras[index];
          return ItemCard(
            titulo: c['nombre'] as String,
            subtitulo: c['zona'] as String,
            disponible: c['disponible'] as bool,
            color: Colors.green,
            onReservar: () {
              onReservar('Computadora', c['nombre'] as String);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✓ Computadora reservada'),
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