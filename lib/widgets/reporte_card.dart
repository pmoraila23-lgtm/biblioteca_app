import 'package:flutter/material.dart';
import '../models/reporte.dart';

class ReporteCard extends StatelessWidget {
  final Reporte reporte;

  const ReporteCard({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_getIcon(), color: _getColor(), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${reporte.tipo} - ${reporte.recurso}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      reporte.usuario,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getEstadoColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  reporte.estado,
                  style: TextStyle(
                    color: _getEstadoColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Descripción
          Text(
            reporte.descripcion,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          // Fecha
          Text(
            reporte.fecha,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (reporte.tipo) {
      case 'Cubículo':
        return Colors.blue;
      case 'Computadora':
        return Colors.green;
      case 'Libro':
        return Colors.purple;
      default:
        return Colors.orange;
    }
  }

  IconData _getIcon() {
    switch (reporte.tipo) {
      case 'Cubículo':
        return Icons.meeting_room;
      case 'Computadora':
        return Icons.computer;
      case 'Libro':
        return Icons.book;
      default:
        return Icons.report_problem;
    }
  }

  Color _getEstadoColor() {
    switch (reporte.estado) {
      case 'Pendiente':
        return Colors.orange;
      case 'En proceso':
        return Colors.blue;
      case 'Resuelto':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}