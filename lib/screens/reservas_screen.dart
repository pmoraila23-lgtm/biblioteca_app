import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/reserva.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});

  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  List<Reserva> reservas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarReservas();
  }

  Future<void> _cargarReservas() async {
    setState(() => isLoading = true);
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/reservas.json');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonData = jsonDecode(jsonString);

        setState(() {
          reservas = (jsonData['reservas'] as List)
              .map((r) => Reserva.fromJson(r))
              .toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar reservas: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _guardarReservas() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/reservas.json');

      final jsonData = {
        'reservas': reservas.map((r) => r.toJson()).toList(),
        'fecha_actualizacion': DateTime.now().toIso8601String(),
      };

      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $e')),
        );
      }
    }
  }

  void _agregarReserva() {
    final libroController = TextEditingController();
    final usuarioController = TextEditingController();
    DateTime? fechaDevolucion;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.add_circle,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              const Text('Nueva Reserva'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: libroController,
                  decoration: const InputDecoration(
                    labelText: 'Libro',
                    prefixIcon: Icon(Icons.book),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: usuarioController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today),
                  title: Text(
                    fechaDevolucion == null
                        ? 'Fecha de devolución'
                        : _formatearFecha(fechaDevolucion!),
                    style: TextStyle(
                      color:
                          fechaDevolucion == null ? Colors.grey : Colors.white,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now().add(const Duration(days: 7)),
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFF6B4CE6),
                              onPrimary: Colors.white,
                              surface: Color(0xFF1E1E2E),
                              onSurface: Colors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (fecha != null) {
                      setDialogState(() {
                        fechaDevolucion = fecha;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (libroController.text.isNotEmpty &&
                    usuarioController.text.isNotEmpty &&
                    fechaDevolucion != null) {
                  setState(() {
                    reservas.add(Reserva(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      libro: libroController.text,
                      usuario: usuarioController.text,
                      fechaPrestamo: DateTime.now(),
                      fechaDevolucion: fechaDevolucion!,
                      devuelto: false,
                    ));
                  });
                  _guardarReservas();
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✓ Reserva creada exitosamente'),
                      backgroundColor: Color(0xFF03DAC6),
                    ),
                  );
                }
              },
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📖 Reservas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _agregarReserva,
            tooltip: 'Nueva reserva',
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6B4CE6),
              ),
            )
          : reservas.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border,
                          size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No hay reservas',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: reservas.length,
                  itemBuilder: (context, index) {
                    final reserva = reservas[index];
                    final diasRestantes = reserva.fechaDevolucion
                        .difference(DateTime.now())
                        .inDays;
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
                                    : const Color(0xFF6B4CE6)
                                        .withOpacity(0.2),
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
                            decoration: reserva.devuelto
                                ? TextDecoration.lineThrough
                                : null,
                            color:
                                reserva.devuelto ? Colors.grey : Colors.white,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.person,
                                    size: 16, color: Colors.grey),
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
                                Text(
                                    'Prestado: ${_formatearFecha(reserva.fechaPrestamo)}'),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.event,
                                  size: 16,
                                  color: atrasado
                                      ? const Color(0xFFFF6B6B)
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Devolver: ${_formatearFecha(reserva.fechaDevolucion)}',
                                  style: TextStyle(
                                    color: atrasado
                                        ? const Color(0xFFFF6B6B)
                                        : Colors.grey,
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
                                      ? const Color(0xFFFF6B6B)
                                          .withOpacity(0.2)
                                      : const Color(0xFFFFB74D)
                                          .withOpacity(0.2),
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
                                  color: const Color(0xFF03DAC6)
                                      .withOpacity(0.2),
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
                                icon: const Icon(Icons.delete,
                                    color: Color(0xFFFF6B6B)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor:
                                          const Color(0xFF1E1E2E),
                                      title: const Text('¿Eliminar reserva?'),
                                      content: const Text(
                                          '¿Estás seguro de eliminar esta reserva?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Cancelar'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              reservas.removeAt(index);
                                            });
                                            _guardarReservas();
                                            Navigator.pop(context);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    '✓ Reserva eliminada'),
                                                backgroundColor:
                                                    Color(0xFFFF6B6B),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFFF6B6B),
                                          ),
                                          child: const Text('Eliminar'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    reservas[index].devuelto = true;
                                  });
                                  _guardarReservas();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('✓ Libro devuelto'),
                                      backgroundColor: Color(0xFF03DAC6),
                                    ),
                                  );
                                },
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
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _agregarReserva,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Reserva'),
        backgroundColor: const Color(0xFF03DAC6),
      ),
    );
  }
}