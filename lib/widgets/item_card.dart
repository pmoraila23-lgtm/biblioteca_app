import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final bool disponible;
  final Color color;
  final VoidCallback onReservar;

  const ItemCard({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.disponible,
    required this.color,
    required this.onReservar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getIcon(),
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitulo,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          disponible
              ? ElevatedButton(
                  onPressed: onReservar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Reservar'),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'No disponible',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    if (color == Colors.blue) return Icons.meeting_room;
    if (color == Colors.green) return Icons.computer;
    return Icons.book;
  }
}