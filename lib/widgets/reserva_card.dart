import 'package:flutter/material.dart';
import '../models/reserva.dart';

class ReservaCard extends StatelessWidget {
  final Reserva reserva;
  final VoidCallback onDevolver;
  final VoidCallback onEliminar;

  const ReservaCard({
    super.key,
    required this.reserva,
    required this.onDevolver,
    required this.onEliminar,
  });

  String _formatearFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    final diasRestantes =
        reserva.fechaDevolucion.difference(DateTime.now()).inDays;
    final atrasado = diasRestantes < 0 && !reserva.devuelto;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: reserva.devuelto
              ? const Color(0xFF03DAC6).withOpacity(0.3)
              : atrasado
                  ? const Color(0xFFFF6B6B).withOpacity(0.3)
                  : const Color(0xFF6B4CE6).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: reserva.devuelto
                ? const Color(0xFF03DAC6).withOpacity(0.2)
                : atrasado
                    ? const Color(0xFFFF6B6B).withOpacity(0.2)
                    : const Color(0xFF6B4CE6).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            reserva.devuelto
                ? Icons.check_circle
                : atrasado
                    ? Icons.warning
                    : Icons.bookmark,
            color: reserva.devuelto
                ? const Color(0xFF03DAC6)
                : atrasado
                    ? const Color(0xFFFF6B6B)
                    : const Color(0xFF6B4CE6),
            size: 32,
          ),
        ),
        title: Text(
          reserva.libro,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration:
                reserva.devuelto ? TextDecoration.lineThrough : null,
            color: reserva.devuelto ? Colors.grey : Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(reserva.usuario),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text('Prestado: ${_formatearFecha(reserva.fechaPrestamo)}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.event,
                  size: 16,
                  color: atrasado ? const Color(0xFFFF6B6B) : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  'Devolver: ${_formatearFecha(reserva.fechaDevolucion)}',
                  style: TextStyle(
                    color: atrasado ? const Color(0xFFFF6B6B) : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (!reserva.devuelto)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: atrasado
                      ? const Color(0xFFFF6B6B).withOpacity(0.2)
                      : const Color(0xFFFFB74D).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  atrasado
                      ? '⚠ Atrasado ${diasRestantes.abs()} días'
                      : '⏱ $diasRestantes días restantes',
                  style: TextStyle(
                    color: atrasado
                        ? const Color(0xFFFF6B6B)
                        : const Color(0xFFFFB74D),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF03DAC6).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '✓ Devuelto',
                  style: TextStyle(
                    color: Color(0xFF03DAC6),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        trailing: reserva.devuelto
            ? IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFFFF6B6B)),
                onPressed: onEliminar,
              )
            : ElevatedButton(
                onPressed: onDevolver,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03DAC6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text('Devolver'),
              ),
      ),
    );
  }
}