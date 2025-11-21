import 'package:flutter/material.dart';
import '../widgets/item_card.dart';

class LibrosScreen extends StatelessWidget {
  final Function(String, String) onReservar;

  const LibrosScreen({super.key, required this.onReservar});

  @override
  Widget build(BuildContext context) {
    final libros = [
      {'titulo': 'Cálculo Diferencial', 'autor': 'James Stewart', 'disponible': 3},
      {'titulo': 'Física Universitaria', 'autor': 'Sears Zemansky', 'disponible': 0},
      {'titulo': 'Programación en Java', 'autor': 'Deitel', 'disponible': 5},
      {'titulo': 'Química Orgánica', 'autor': 'Morrison Boyd', 'disponible': 2},
      {'titulo': 'Álgebra Lineal', 'autor': 'Grossman', 'disponible': 0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Libros')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: libros.length,
        itemBuilder: (context, index) {
          final l = libros[index];
          final disponibles = l['disponible'] as int;

          return ItemCard(
            titulo: l['titulo'] as String,
            subtitulo: '${l['autor']} • $disponibles disponibles',
            disponible: disponibles > 0,
            color: Colors.purple,
            onReservar: () {
              onReservar('Libro', l['titulo'] as String);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✓ Libro reservado'),
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