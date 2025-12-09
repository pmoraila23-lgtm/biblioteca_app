import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class LibrosScreen extends StatefulWidget {
  const LibrosScreen({super.key});

  @override
  State<LibrosScreen> createState() => _LibrosScreenState();
}

class _LibrosScreenState extends State<LibrosScreen> {
  List<Libro> libros = [];
  bool isLoading = true;
  String busqueda = '';

  @override
  void initState() {
    super.initState();
    _cargarLibros();
  }

  Future<void> _cargarLibros() async {
    setState(() => isLoading = true);
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/libros.json');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonData = jsonDecode(jsonString);

        setState(() {
          libros = (jsonData['libros'] as List)
              .map((l) => Libro.fromJson(l))
              .toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar libros: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _guardarLibros() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/libros.json');

      final jsonData = {
        'libros': libros.map((l) => l.toJson()).toList(),
        'fecha_actualizacion': DateTime.now().toIso8601String(),
      };

      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $e')),
        );
      }
    }
  }

  void _agregarLibro() {
    final tituloController = TextEditingController();
    final autorController = TextEditingController();
    final isbnController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.add_circle, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            const Text('Agregar Libro'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  prefixIcon: Icon(Icons.book),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: autorController,
                decoration: const InputDecoration(
                  labelText: 'Autor',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: isbnController,
                decoration: const InputDecoration(
                  labelText: 'ISBN',
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (tituloController.text.isNotEmpty &&
                  autorController.text.isNotEmpty) {
                setState(() {
                  libros.add(Libro(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    titulo: tituloController.text,
                    autor: autorController.text,
                    isbn: isbnController.text,
                    disponible: true,
                  ));
                });
                _guardarLibros();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✓ Libro agregado exitosamente'),
                    backgroundColor: Color(0xFF03DAC6),
                  ),
                );
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  List<Libro> get librosFiltrados {
    if (busqueda.isEmpty) return libros;

    return libros.where((libro) {
      return libro.titulo.toLowerCase().contains(busqueda.toLowerCase()) ||
          libro.autor.toLowerCase().contains(busqueda.toLowerCase()) ||
          libro.isbn.toLowerCase().contains(busqueda.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final librosMostrados = librosFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Libros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _agregarLibro,
            tooltip: 'Agregar libro',
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar libro',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: busqueda.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => busqueda = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() => busqueda = value);
              },
            ),
          ),

          // Lista de libros
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6B4CE6),
                    ),
                  )
                : librosMostrados.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              busqueda.isEmpty
                                  ? Icons.library_books
                                  : Icons.search_off,
                              size: 80,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              busqueda.isEmpty
                                  ? 'No hay libros'
                                  : 'No se encontraron resultados',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: librosMostrados.length,
                        itemBuilder: (context, index) {
                          final libro = librosMostrados[index];
                          final libroIndex = libros.indexOf(libro);

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: libro.disponible
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
                                  color: const Color(0xFF6B4CE6)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.book,
                                  color: Color(0xFF6B4CE6),
                                  size: 32,
                                ),
                              ),
                              title: Text(
                                libro.titulo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(libro.autor),
                                    ],
                                  ),
                                  if (libro.isbn.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.numbers,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(libro.isbn),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: libro.disponible
                                          ? const Color(0xFF03DAC6)
                                              .withOpacity(0.2)
                                          : const Color(0xFFFF6B6B)
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      libro.disponible
                                          ? '✓ Disponible'
                                          : '✗ Prestado',
                                      style: TextStyle(
                                        color: libro.disponible
                                            ? const Color(0xFF03DAC6)
                                            : const Color(0xFFFF6B6B),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Icon(
                                          libro.disponible
                                              ? Icons.book_online
                                              : Icons.assignment_return,
                                          color: libro.disponible
                                              ? const Color(0xFFFF6B6B)
                                              : const Color(0xFF03DAC6),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(libro.disponible
                                            ? 'Prestar'
                                            : 'Devolver'),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        libros[libroIndex].disponible =
                                            !libro.disponible;
                                      });
                                      _guardarLibros();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            libro.disponible
                                                ? '✓ Libro devuelto'
                                                : '✓ Libro prestado',
                                          ),
                                          backgroundColor: libro.disponible
                                              ? const Color(0xFF03DAC6)
                                              : const Color(0xFFFF6B6B),
                                        ),
                                      );
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Row(
                                      children: [
                                        Icon(Icons.delete,
                                            color: Color(0xFFFF6B6B)),
                                        SizedBox(width: 12),
                                        Text('Eliminar'),
                                      ],
                                    ),
                                    onTap: () {
                                      Future.delayed(
                                        const Duration(milliseconds: 100),
                                        () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  const Color(0xFF1E1E2E),
                                              title: const Text(
                                                  '¿Eliminar libro?'),
                                              content: const Text(
                                                  '¿Estás seguro de eliminar este libro?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child:
                                                      const Text('Cancelar'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      libros.removeAt(
                                                          libroIndex);
                                                    });
                                                    _guardarLibros();
                                                    Navigator.pop(context);

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            '✓ Libro eliminado'),
                                                        backgroundColor:
                                                            Color(0xFFFF6B6B),
                                                      ),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFFF6B6B),
                                                  ),
                                                  child: const Text('Eliminar'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _agregarLibro,
        icon: const Icon(Icons.add),
        label: const Text('Agregar Libro'),
        backgroundColor: const Color(0xFF6B4CE6),
      ),
    );
  }
}

class Libro {
  final String id;
  final String titulo;
  final String autor;
  final String isbn;
  bool disponible;

  Libro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.disponible,
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    return Libro(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      autor: json['autor'] ?? '',
      isbn: json['isbn'] ?? '',
      disponible: json['disponible'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'isbn': isbn,
      'disponible': disponible,
    };
  }
}