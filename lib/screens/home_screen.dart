import 'package:flutter/material.dart';
import '../models/reserva.dart';
import '../models/reporte.dart';
import '../widgets/menu_card.dart';
import '../widgets/reporte_card.dart';
import 'bienvenida_screen.dart';
import 'cubiculos_screen.dart';
import 'computadoras_screen.dart';
import 'libros_screen.dart';
import 'reservas_screen.dart';
import 'agregar_reporte_screen.dart';
import 'reportes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Reserva> _reservas = [];
  final List<Reporte> _reportes = [
    // Reportes de ejemplo
    Reporte(
      id: 1,
      tipo: 'Computadora',
      recurso: 'PC-02',
      descripcion: 'La computadora no enciende, parece que no tiene corriente.',
      usuario: 'Juan Pérez',
      fecha: 'Hace 2 horas',
      estado: 'Pendiente',
    ),
    Reporte(
      id: 2,
      tipo: 'Cubículo',
      recurso: 'C-103',
      descripcion: 'El aire acondicionado no funciona correctamente.',
      usuario: 'María García',
      fecha: 'Hace 5 horas',
      estado: 'En proceso',
    ),
    Reporte(
      id: 3,
      tipo: 'Otro',
      recurso: 'Baños',
      descripcion: 'Falta papel en los baños del segundo piso.',
      usuario: 'Carlos López',
      fecha: 'Ayer',
      estado: 'Resuelto',
    ),
  ];

  void _agregarReserva(String tipo, String nombre) {
    setState(() {
      _reservas.add(Reserva(
        id: DateTime.now().millisecondsSinceEpoch,
        tipo: tipo,
        nombre: nombre,
        fecha: 'Hoy',
      ));
    });
  }

  void _cancelarReserva(int id) {
    setState(() {
      _reservas.removeWhere((r) => r.id == id);
    });
  }

  void _agregarReporte(Reporte reporte) {
    setState(() {
      _reportes.insert(0, reporte);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? _buildHome()
          : _currentIndex == 1
              ? ReservasScreen(reservas: _reservas, onCancelar: _cancelarReserva)
              : ReportesScreen(reportes: _reportes),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Reservas'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reportes'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AgregarReporteScreen(onAgregar: _agregarReporte),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biblioteca',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hola, Estudiante',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const BienvenidaScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // Menú
          Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                MenuCard(
                  icon: Icons.meeting_room,
                  color: Colors.blue,
                  titulo: 'Cubículos',
                  subtitulo: 'Reservar espacio',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CubiculosScreen(onReservar: _agregarReserva),
                    ),
                  ),
                ),
                MenuCard(
                  icon: Icons.computer,
                  color: Colors.green,
                  titulo: 'Computadoras',
                  subtitulo: 'Reservar equipo',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ComputadorasScreen(onReservar: _agregarReserva),
                    ),
                  ),
                ),
                MenuCard(
                  icon: Icons.book,
                  color: Colors.purple,
                  titulo: 'Libros',
                  subtitulo: 'Buscar libros',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LibrosScreen(onReservar: _agregarReserva),
                    ),
                  ),
                ),
                MenuCard(
                  icon: Icons.calendar_today,
                  color: Colors.orange,
                  titulo: 'Mis Reservas',
                  subtitulo: '${_reservas.length} activas',
                  onTap: () => setState(() => _currentIndex = 1),
                ),
              ],
            ),
          ),

          // Feed de reportes recientes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reportes Recientes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _currentIndex = 2),
                  child: const Text('Ver todos'),
                ),
              ],
            ),
          ),

          // Lista de reportes recientes
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            child: _reportes.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'No hay reportes recientes',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : Column(
                    children: _reportes
                        .take(3)
                        .map((r) => ReporteCard(reporte: r))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}