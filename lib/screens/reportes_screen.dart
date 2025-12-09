import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/reporte.dart';
import 'agregar_reporte_screen.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  State<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  List<Reporte> reportes = [];
  bool isLoading = true;
  String filtro = 'todos'; // todos, resueltos, pendientes

  @override
  void initState() {
    super.initState();
    _cargarReportes();
  }

  Future<void> _cargarReportes() async {
    setState(() => isLoading = true);
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/reportes.json');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonData = jsonDecode(jsonString);

        setState(() {
          reportes = (jsonData['reportes'] as List)
              .map((r) => Reporte.fromJson(r))
              .toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar reportes: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _guardarReportes() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/reportes.json');

      final jsonData = {
        'reportes': reportes.map((r) => r.toJson()).toList(),
        'fecha_actualizacion': DateTime.now().toIso8601String(),
      };

      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _editarReporte(int index) {
    final reporte = reportes[index];
    final tituloController = TextEditingController(text: reporte.titulo);
    final descripcionController =
        TextEditingController(text: reporte.descripcion);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            const Text('Editar Reporte'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (tituloController.text.isNotEmpty) {
                setState(() {
                  reportes[index].titulo = tituloController.text;
                  reportes[index].descripcion = descripcionController.text;
                });
                _guardarReportes();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✓ Reporte actualizado'),
                    backgroundColor: Color(0xFF03DAC6),
                  ),
                );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _eliminarReporte(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Color(0xFFFF6B6B)),
            SizedBox(width: 12),
            Text('Confirmar Eliminación'),
          ],
        ),
        content: const Text('¿Estás seguro de eliminar este reporte?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                reportes.removeAt(index);
              });
              _guardarReportes();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✓ Reporte eliminado'),
                  backgroundColor: Color(0xFFFF6B6B),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  List<Reporte> get reportesFiltrados {
    switch (filtro) {
      case 'resueltos':
        return reportes.where((r) => r.resuelto).toList();
      case 'pendientes':
        return reportes.where((r) => !r.resuelto).toList();
      default:
        return reportes;
    }
  }

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
    final reportesMostrados = reportesFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📋 Reportes'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() => filtro = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'todos',
                child: Row(
                  children: [
                    Icon(Icons.list, color: Color(0xFF6B4CE6)),
                    SizedBox(width: 12),
                    Text('Todos'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'pendientes',
                child: Row(
                  children: [
                    Icon(Icons.error, color: Color(0xFFFF6B6B)),
                    SizedBox(width: 12),
                    Text('Pendientes'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'resueltos',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF03DAC6)),
                    SizedBox(width: 12),
                    Text('Resueltos'),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgregarReporteScreen(),
                ),
              );

              if (result == true) {
                _cargarReportes();
              }
            },
            tooltip: 'Agregar reporte',
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6B4CE6),
              ),
            )
          : reportesMostrados.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        filtro == 'resueltos'
                            ? Icons.check_circle_outline
                            : filtro == 'pendientes'
                                ? Icons.error_outline
                                : Icons.inbox,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        filtro == 'resueltos'
                            ? 'No hay reportes resueltos'
                            : filtro == 'pendientes'
                                ? 'No hay reportes pendientes'
                                : 'No hay reportes',
                        style: const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: reportesMostrados.length,
                  itemBuilder: (context, index) {
                    final reporte = reportesMostrados[index];
                    final reporteIndex = reportes.indexOf(reporte);

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
                            reporte.resuelto
                                ? Icons.check_circle
                                : Icons.error,
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
                            decoration: reporte.resuelto
                                ? TextDecoration.lineThrough
                                : null,
                            color:
                                reporte.resuelto ? Colors.grey : Colors.white,
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
                            // Switch para marcar resuelto/pendiente
                            Switch(
                              value: reporte.resuelto,
                              onChanged: (value) {
                                setState(() {
                                  reportes[reporteIndex].resuelto = value;
                                });
                                _guardarReportes();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value
                                          ? '✓ Marcado como resuelto'
                                          : '⚠ Marcado como pendiente',
                                    ),
                                    backgroundColor: value
                                        ? const Color(0xFF03DAC6)
                                        : const Color(0xFFFF6B6B),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              activeColor: const Color(0xFF03DAC6),
                              activeTrackColor:
                                  const Color(0xFF03DAC6).withOpacity(0.5),
                            ),
                            // Botón de opciones
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'editar',
                                  child: const Row(
                                    children: [
                                      Icon(Icons.edit,
                                          color: Color(0xFF6B4CE6)),
                                      SizedBox(width: 12),
                                      Text('Editar'),
                                    ],
                                  ),
                                  onTap: () {
                                    Future.delayed(
                                      const Duration(milliseconds: 100),
                                      () => _editarReporte(reporteIndex),
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  value: 'eliminar',
                                  child: const Row(
                                    children: [
                                      Icon(Icons.delete,
                                          color: Color(0xFFFF6B6B)),
                                      SizedBox(width: 12),
                                      Text('Eliminar'),
                                    ],
                                  ),
                                  onTap: () {
                                    Future.delayed(
                                      const Duration(milliseconds: 100),
                                      () => _eliminarReporte(reporteIndex),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgregarReporteScreen(),
            ),
          );

          if (result == true) {
            _cargarReportes();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Reporte'),
        backgroundColor: const Color(0xFFFF6B6B),
      ),
    );
  }
}