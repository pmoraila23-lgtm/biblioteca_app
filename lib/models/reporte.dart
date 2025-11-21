class Reporte {
  final int id;
  final String tipo; // Cubículo, Computadora, Libro, Otro
  final String recurso; // C-101, PC-02, etc.
  final String descripcion;
  final String usuario;
  final String fecha;
  final String estado; // Pendiente, En proceso, Resuelto

  Reporte({
    required this.id,
    required this.tipo,
    required this.recurso,
    required this.descripcion,
    required this.usuario,
    required this.fecha,
    required this.estado,
  });
}