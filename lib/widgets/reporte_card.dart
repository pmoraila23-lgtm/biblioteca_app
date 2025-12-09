import 'package:flutter/material.dart';
import '../models/reporte.dart';

class ReporteCard extends StatelessWidget {
  final Reporte reporte;
  final Function(bool) onResueltoCambiado;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const ReporteCard({
    super.key,
    required this.reporte,
    required this.onResueltoCambiado,
    required this.onEditar,
    required this.onEliminar,
  });

  String _formatearFecha(DateTime fecha) {
    final meses = [
      'ene',
      'feb',
      'mar',
      'abr',
      'may',
      'jun',
      'jul',
      'ago',
      'sep',
      'oct',
      'nov',
      'dic'
    ];
    return '${fecha.day} ${meses[fecha.month - 1]} ${fecha.year} • ${fecha.hour}:${fecha.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: reporte.resuelto
              ? const Color(0xFF03DAC6).withOpacity(0.3)
              : const Color(0xFFFF6B6B).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: reporte.resuelto
                ? const Color(0xFF03DAC6).withOpacity(0.2)
                : const Color(0xFFFF6B6B).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            reporte.resuelto ? Icons.check_circle : Icons.error,
            color: reporte.resuelto
                ? const Color(0xFF03DAC6)
                : const Color(0xFFFF6B6B),
            size: 32,
          ),
        ),
        title: Text(
          reporte.titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration:
                reporte.resuelto ? TextDecoration.lineThrough : null,
            color: reporte.resuelto ? Colors.grey : Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (reporte.descripcion.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                reporte.descripcion,
                style: TextStyle(
                  color: reporte.resuelto
                      ? Colors.grey
                      : const Color(0xFFB0B0B0),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatearFecha(reporte.fecha),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: reporte.resuelto,
              onChanged: onResueltoCambiado,
              activeColor: const Color(0xFF03DAC6),
              activeTrackColor: const Color(0xFF03DAC6).withOpacity(0.5),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'editar',
                  child: const Row(
                    children: [
                      Icon(Icons.edit, color: Color(0xFF6B4CE6)),
                      SizedBox(width: 12),
                      Text('Editar'),
                    ],
                  ),
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      onEditar,
                    );
                  },
                ),
                PopupMenuItem(
                  value: 'eliminar',
                  child: const Row(
                    children: [
                      Icon(Icons.delete, color: Color(0xFFFF6B6B)),
                      SizedBox(width: 12),
                      Text('Eliminar'),
                    ],
                  ),
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      onEliminar,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}