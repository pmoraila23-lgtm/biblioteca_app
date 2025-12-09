import 'package:flutter/material.dart';
import 'reportes_screen.dart';
import 'libros_screen.dart';
import 'reservas_screen.dart';
import 'computadoras_screen.dart';
import 'cubiculos_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Biblioteca'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1E1E2E),
                  title: const Text('Cerrar Sesión'),
                  content: const Text('¿Estás seguro de que quieres salir?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B6B),
                      ),
                      child: const Text('Salir'),
                    ),
                  ],
                ),
              );
            },
            tooltip: 'Cerrar sesión',
          ),
        ],
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuCard(
                  context,
                  icon: Icons.book,
                  title: 'Libros',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B4CE6), Color(0xFF8B6CE8)],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LibrosScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.bookmark,
                  title: 'Reservas',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF03DAC6), Color(0xFF00BFA5)],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReservasScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.report_problem,
                  title: 'Reportes',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF8787)],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportesScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.computer,
                  title: 'Computadoras',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB74D), Color(0xFFFFCC80)],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComputadorasScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.meeting_room,
                  title: 'Cubículos',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CubiculosScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.analytics,
                  title: 'Estadísticas',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('📊 Próximamente...'),
                        backgroundColor: Color(0xFF4CAF50),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}