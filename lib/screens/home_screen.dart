import 'package:flutter/material.dart';
import '../models/reserva.dart';
import '../widgets/menu_card.dart';
import 'login_screen.dart';
import 'cubiculos_screen.dart';
import 'computadoras_screen.dart';
import 'libros_screen.dart';
import 'reservas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Reserva> _reservas = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? _buildHome()
          : ReservasScreen(
              reservas: _reservas,
              onCancelar: _cancelarReserva,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Reservas'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Column(
      children: [
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
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.count(
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
        ),
      ],
    );
  }
}