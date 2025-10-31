import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/data/terapeutas_data.dart'; // Importa la fuente de datos
import 'package:myapp/menu.dart';

class Terapeutas extends StatefulWidget {
  const Terapeutas({super.key});

  @override
  State<Terapeutas> createState() => _TerapeutasState();
}

class _TerapeutasState extends State<Terapeutas> {
  String _selectedFilter = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  // La lista ahora se consume desde la fuente de datos, no se declara aquí
  List<Terapeuta> get _terapeutasFiltrados {
    List<Terapeuta> filteredList;
    if (_selectedFilter == 'Todos') {
      filteredList = terapeutas; // Usa la lista importada
    } else {
      filteredList = terapeutas
          .where((terapeuta) => terapeuta.especialidad == _selectedFilter)
          .toList();
    }

    final searchQuery = _searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      return filteredList.where((terapeuta) {
        return terapeuta.nombre.toLowerCase().contains(searchQuery) ||
               terapeuta.especialidad.toLowerCase().contains(searchQuery);
      }).toList();
    }

    return filteredList;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {}); // Actualiza la UI al escribir en el buscador
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: const Menu(),
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
    final formatCurrency = NumberFormat("\$ #,##0", "es_CO");

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
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
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
                        '${formatCurrency.format(terapeuta.precio)}/sesión',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
