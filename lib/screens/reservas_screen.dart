import 'package:flutter/material.dart';
import '../models/reserva.dart';
import '../widgets/reserva_card.dart';

class ReservasScreen extends StatelessWidget {
  final List<Reserva> reservas;
  final Function(int) onCancelar;

  const ReservasScreen({
    super.key,
    required this.reservas,
    required this.onCancelar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reservas'),
        automaticallyImplyLeading: false,
      ),
      body: reservas.isEmpty ? _buildEmpty() : _buildList(context),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today,
              size: 60,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No tienes reservas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tus reservas aparecerán aquí',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reservas.length,
      itemBuilder: (context, index) {
        final reserva = reservas[index];
        return ReservaCard(
          reserva: reserva,
          onCancelar: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Cancelar Reserva'),
                content: const Text('¿Estás seguro?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      onCancelar(reserva.id);
                      Navigator.pop(ctx);
                    },
                    child: const Text('Sí', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}