class Reporte {
  String id;
  String titulo;
  String descripcion;
  final DateTime fecha;
  bool resuelto;

  Reporte({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.resuelto,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fecha: DateTime.parse(json['fecha']),
      resuelto: json['resuelto'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'resuelto': resuelto,
    };
  }
}