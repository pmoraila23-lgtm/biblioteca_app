import 'package:flutter/material.dart';
import '../models/reserva.dart';

class ReservaCard extends StatelessWidget {
  final Reserva reserva;
  final VoidCallback onCancelar;

  const ReservaCard({
    super.key,
    required this.reserva,
    required this.onCancelar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getIcon(),
              color: _getColor(),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reserva.tipo.toUpperCase(),
                  style: TextStyle(
                    color: _getColor(),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reserva.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reserva.fecha,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onCancelar,
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (reserva.tipo) {
      case 'Cubículo':
        return Colors.blue;
      case 'Computadora':
        return Colors.green;
      case 'Libro':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  IconData _getIcon() {
    switch (reserva.tipo) {
      case 'Cubículo':
        return Icons.meeting_room;
      case 'Computadora':
        return Icons.computer;
      case 'Libro':
        return Icons.book;
      default:
        return Icons.calendar_today;
    }
  }
}