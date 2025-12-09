class Reserva {
  final String id;
  final String libro;
  final String usuario;
  final DateTime fechaPrestamo;
  final DateTime fechaDevolucion;
  bool devuelto;

  Reserva({
    required this.id,
    required this.libro,
    required this.usuario,
    required this.fechaPrestamo,
    required this.fechaDevolucion,
    required this.devuelto,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      id: json['id'] ?? '',
      libro: json['libro'] ?? '',
      usuario: json['usuario'] ?? '',
      fechaPrestamo: DateTime.parse(json['fechaPrestamo']),
      fechaDevolucion: DateTime.parse(json['fechaDevolucion']),
      devuelto: json['devuelto'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libro': libro,
      'usuario': usuario,
      'fechaPrestamo': fechaPrestamo.toIso8601String(),
      'fechaDevolucion': fechaDevolucion.toIso8601String(),
      'devuelto': devuelto,
    };
  }
}