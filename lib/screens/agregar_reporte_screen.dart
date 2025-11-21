import 'package:flutter/material.dart';
import '../models/reporte.dart';

class AgregarReporteScreen extends StatefulWidget {
  final Function(Reporte) onAgregar;

  const AgregarReporteScreen({super.key, required this.onAgregar});

  @override
  State<AgregarReporteScreen> createState() => _AgregarReporteScreenState();
}

class _AgregarReporteScreenState extends State<AgregarReporteScreen> {
  String _tipoSeleccionado = 'Cubículo';
  String _recursoSeleccionado = '';
  final _descripcionController = TextEditingController();

  final Map<String, List<String>> _recursos = {
    'Cubículo': ['C-101', 'C-102', 'C-103', 'C-201', 'C-202', 'C-203'],
    'Computadora': ['PC-01', 'PC-02', 'PC-03', 'PC-04', 'PC-05', 'PC-06'],
    'Libro': ['Cálculo', 'Física', 'Programación', 'Química', 'Álgebra'],
    'Otro': ['Baños', 'Iluminación', 'Aire acondicionado', 'Mobiliario'],
  };

  @override
  void initState() {
    super.initState();
    _recursoSeleccionado = _recursos[_tipoSeleccionado]!.first;
  }

  @override
  void dispose() {
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Reporte')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.report_problem,
                  size: 50,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tipo de reporte
            const Text(
              '¿Qué deseas reportar?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<String>(
                value: _tipoSeleccionado,
                isExpanded: true,
                underline: const SizedBox(),
                items: ['Cubículo', 'Computadora', 'Libro', 'Otro']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _tipoSeleccionado = value!;
                    _recursoSeleccionado = _recursos[_tipoSeleccionado]!.first;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // Recurso específico
            const Text(
              '¿Cuál es el recurso?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<String>(
                value: _recursoSeleccionado,
                isExpanded: true,
                underline: const SizedBox(),
                items: _recursos[_tipoSeleccionado]!
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _recursoSeleccionado = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // Descripción
            const Text(
              'Describe el problema',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descripcionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Ej: La computadora no enciende...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Botón enviar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_descripcionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Escribe una descripción'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final nuevoReporte = Reporte(
                    id: DateTime.now().millisecondsSinceEpoch,
                    tipo: _tipoSeleccionado,
                    recurso: _recursoSeleccionado,
                    descripcion: _descripcionController.text,
                    usuario: 'Estudiante',
                    fecha: 'Hace un momento',
                    estado: 'Pendiente',
                  );

                  widget.onAgregar(nuevoReporte);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✓ Reporte enviado'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Enviar Reporte',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}