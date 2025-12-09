import 'package:flutter/material.dart';

class ComputadorasScreen extends StatefulWidget {
  const ComputadorasScreen({super.key});

  @override
  State<ComputadorasScreen> createState() => _ComputadorasScreenState();
}

class _ComputadorasScreenState extends State<ComputadorasScreen> {
  List<Computadora> computadoras = [
    Computadora(id: '1', numero: 'PC-001', disponible: true),
    Computadora(id: '2', numero: 'PC-002', disponible: true),
    Computadora(id: '3', numero: 'PC-003', disponible: false),
    Computadora(id: '4', numero: 'PC-004', disponible: true),
    Computadora(id: '5', numero: 'PC-005', disponible: false),
    Computadora(id: '6', numero: 'PC-006', disponible: true),
  ];

  @override
  Widget build(BuildContext context) {
    final disponibles = computadoras.where((c) => c.disponible).length;
    final ocupadas = computadoras.length - disponibles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('💻 Computadoras'),
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
                      'Ocupadas',
                      ocupadas.toString(),
                      const Color(0xFFFF6B6B),
                      Icons.computer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Total',
                      computadoras.length.toString(),
                      const Color(0xFF6B4CE6),
                      Icons.desktop_windows,
                    ),
                  ),
                ],
              ),
            ),

            // Grid de computadoras
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: computadoras.length,
                itemBuilder: (context, index) {
                  final computadora = computadoras[index];
                  return _buildComputadoraCard(computadora, index);
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

  Widget _buildComputadoraCard(Computadora computadora, int index) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: computadora.disponible
              ? const Color(0xFF03DAC6).withOpacity(0.3)
              : const Color(0xFFFF6B6B).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            computadoras[index].disponible = !computadora.disponible;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                computadoras[index].disponible
                    ? '✓ ${computadora.numero} marcada como disponible'
                    : '✗ ${computadora.numero} marcada como ocupada',
              ),
              backgroundColor: computadoras[index].disponible
                  ? const Color(0xFF03DAC6)
                  : const Color(0xFFFF6B6B),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.computer,
                size: 48,
                color: computadora.disponible
                    ? const Color(0xFF03DAC6)
                    : const Color(0xFFFF6B6B),
              ),
              const SizedBox(height: 12),
              Text(
                computadora.numero,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: computadora.disponible
                      ? const Color(0xFF03DAC6).withOpacity(0.2)
                      : const Color(0xFFFF6B6B).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  computadora.disponible ? 'Disponible' : 'Ocupada',
                  style: TextStyle(
                    color: computadora.disponible
                        ? const Color(0xFF03DAC6)
                        : const Color(0xFFFF6B6B),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Computadora {
  final String id;
  final String numero;
  bool disponible;

  Computadora({
    required this.id,
    required this.numero,
    required this.disponible,
  });
}