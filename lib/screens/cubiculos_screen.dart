import 'package:flutter/material.dart';

class CubiculosScreen extends StatefulWidget {
  const CubiculosScreen({super.key});

  @override
  State<CubiculosScreen> createState() => _CubiculosScreenState();
}

class _CubiculosScreenState extends State<CubiculosScreen> {
  List<Cubiculo> cubiculos = [
    Cubiculo(id: '1', numero: 'CUB-A1', capacidad: 4, disponible: true),
    Cubiculo(id: '2', numero: 'CUB-A2', capacidad: 4, disponible: false),
    Cubiculo(id: '3', numero: 'CUB-B1', capacidad: 6, disponible: true),
    Cubiculo(id: '4', numero: 'CUB-B2', capacidad: 6, disponible: true),
    Cubiculo(id: '5', numero: 'CUB-C1', capacidad: 8, disponible: false),
    Cubiculo(id: '6', numero: 'CUB-C2', capacidad: 8, disponible: true),
  ];

  @override
  Widget build(BuildContext context) {
    final disponibles = cubiculos.where((c) => c.disponible).length;
    final ocupados = cubiculos.length - disponibles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🏢 Cubículos'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF121218),
              const Color(0xFF1E1E2E).withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            // Estadísticas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Disponibles',
                      disponibles.toString(),
                      const Color(0xFF03DAC6),
                      Icons.check_circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Ocupados',
                      ocupados.toString(),
                      const Color(0xFFFF6B6B),
                      Icons.meeting_room,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Total',
                      cubiculos.length.toString(),
                      const Color(0xFF6B4CE6),
                      Icons.business,
                    ),
                  ),
                ],
              ),
            ),

            // Lista de cubículos
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cubiculos.length,
                itemBuilder: (context, index) {
                  final cubiculo = cubiculos[index];
                  return _buildCubiculoCard(cubiculo, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, Color color, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCubiculoCard(Cubiculo cubiculo, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: cubiculo.disponible
              ? const Color(0xFF03DAC6).withOpacity(0.3)
              : const Color(0xFFFF6B6B).withOpacity(0.3),
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
            color: cubiculo.disponible
                ? const Color(0xFF03DAC6).withOpacity(0.2)
                : const Color(0xFFFF6B6B).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.meeting_room,
            color: cubiculo.disponible
                ? const Color(0xFF03DAC6)
                : const Color(0xFFFF6B6B),
            size: 32,
          ),
        ),
        title: Text(
          cubiculo.numero,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text('Capacidad: ${cubiculo.capacidad} personas'),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: cubiculo.disponible
                    ? const Color(0xFF03DAC6).withOpacity(0.2)
                    : const Color(0xFFFF6B6B).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                cubiculo.disponible ? '✓ Disponible' : '✗ Ocupado',
                style: TextStyle(
                  color: cubiculo.disponible
                      ? const Color(0xFF03DAC6)
                      : const Color(0xFFFF6B6B),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            setState(() {
              cubiculos[index].disponible = !cubiculo.disponible;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  cubiculos[index].disponible
                      ? '✓ ${cubiculo.numero} liberado'
                      : '✓ ${cubiculo.numero} reservado',
                ),
                backgroundColor: cubiculos[index].disponible
                    ? const Color(0xFF03DAC6)
                    : const Color(0xFFFF6B6B),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: cubiculo.disponible
                ? const Color(0xFFFF6B6B)
                : const Color(0xFF03DAC6),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          child: Text(cubiculo.disponible ? 'Reservar' : 'Liberar'),
        ),
      ),
    );
  }
}

class Cubiculo {
  final String id;
  final String numero;
  final int capacidad;
  bool disponible;

  Cubiculo({
    required this.id,
    required this.numero,
    required this.capacidad,
    required this.disponible,
  });
}