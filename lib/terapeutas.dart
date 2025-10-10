import 'package:flutter/material.dart';

class Terapeuta {
  final String nombre;
  final String especialidad;
  final String subEspecialidad;
  final String descripcion;
  final String imagen;
  final double calificacion;
  final int resenas;
  final int aniosExperiencia;
  final String consultorio;
  final String precio;

  Terapeuta({
    required this.nombre,
    required this.especialidad,
    required this.subEspecialidad,
    required this.descripcion,
    required this.imagen,
    required this.calificacion,
    required this.resenas,
    required this.aniosExperiencia,
    required this.consultorio,
    required this.precio,
  });
}

class Terapeutas extends StatefulWidget {
  const Terapeutas({super.key});

  @override
  State<Terapeutas> createState() => _TerapeutasState();
}

class _TerapeutasState extends State<Terapeutas> {
  String _selectedFilter = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  final List<Terapeuta> _terapeutas = [
    Terapeuta(
      nombre: 'Dra. María Elena Rodríguez',
      especialidad: 'Psicólogos',
      subEspecialidad: 'Psicología Clínica y Terapia Cognitiva',
      descripcion:
          'Especialista en terapia cognitivo-conductual con enfoque en ansiedad y depresión.',
      imagen: 'assets/images/logo.png',
      calificacion: 4.9,
      resenas: 127,
      aniosExperiencia: 12,
      consultorio: 'Consultorio Gratitud',
      precio: '80.000',
    ),
    Terapeuta(
      nombre: 'Carlos López',
      especialidad: 'Terapeutas Holísticos',
      subEspecialidad: 'Terapia de Reiki y Sanación Energética',
      descripcion:
          'Maestro de Reiki con amplia experiencia en la sanación y el equilibrio de los chakras.',
      imagen: 'assets/images/consultorio.png',
      calificacion: 4.8,
      resenas: 98,
      aniosExperiencia: 10,
      consultorio: 'Espacio Ser Interior',
      precio: '60.000',
    ),
    Terapeuta(
      nombre: 'Sofía Castro',
      especialidad: 'Coach Personal',
      subEspecialidad: 'Coaching de Vida y Desarrollo Profesional',
      descripcion:
          'Ayudo a las personas a alcanzar sus metas y a vivir una vida más plena y con propósito.',
      imagen: 'assets/images/consultorio2.png',
      calificacion: 5.0,
      resenas: 153,
      aniosExperiencia: 8,
      consultorio: 'Online',
      precio: '70.000',
    ),
  ];

  List<Terapeuta> get _terapeutasFiltrados {
    if (_selectedFilter == 'Todos') {
      return _terapeutas;
    } else {
      return _terapeutas
          .where((terapeuta) => terapeuta.especialidad == _selectedFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/images/logo.png', height: 100),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(128, 90, 213, 1),
                    Color.fromRGBO(75, 0, 130, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Encuentra tu Terapeuta Ideal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Conecta con profesionales certificados en psicología, terapias holísticas y coaching personal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.search, color: Colors.grey),
                            hintText: 'Buscar por nombre o especialidad...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('Todos'),
                          const SizedBox(width: 10),
                          _buildFilterChip('Psicólogos'),
                          const SizedBox(width: 10),
                          _buildFilterChip('Terapeutas Holísticos'),
                          const SizedBox(width: 10),
                          _buildFilterChip('Coach Personal'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _terapeutasFiltrados.length,
              itemBuilder: (context, index) {
                return _buildTherapistCard(_terapeutasFiltrados[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.pinkAccent,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      avatar: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
    );
  }

  Widget _buildTherapistCard(Terapeuta terapeuta) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                terapeuta.imagen,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        terapeuta.nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        ' ${terapeuta.calificacion}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '(${terapeuta.resenas} reseñas)',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Chip(
                    label: Text(terapeuta.especialidad),
                    backgroundColor: Colors.blue.shade100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    terapeuta.subEspecialidad,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    terapeuta.descripcion,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.work_outline, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text('${terapeuta.aniosExperiencia} años de experiencia'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(terapeuta.consultorio),
                    ],
                  ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${terapeuta.precio}/sesión',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chat_bubble_outline),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Ver Perfil',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
