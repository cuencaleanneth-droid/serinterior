import 'package:flutter/material.dart';
import 'package:myapp/reservas_data.dart';
import 'package:myapp/mis_reservas_screen.dart';
import 'package:myapp/consultorio_detail_screen.dart';
import 'package:myapp/menu.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});

  @override
  ReservasScreenState createState() => ReservasScreenState();
}

class ReservasScreenState extends State<ReservasScreen> {
  bool _showMisReservas = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabs(),
          Expanded(
            child: _showMisReservas
                ? const MisReservasScreen()
                : _buildConsultoriosList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
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
              'Reserva tu Espacio Ideal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Consultorios y salones equipados en nuestra casa Ser Interior',
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
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showMisReservas = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: !_showMisReservas ? Colors.blue : Colors.grey,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ver Espacios'),
          ),
          const SizedBox(width: 8.0),
          TextButton(
            onPressed: () {
              setState(() {
                _showMisReservas = true;
              });
            },
            child: Text(
              'Mis Reservas',
              style: TextStyle(
                color: _showMisReservas ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () => _showFilterDialog(context),
            icon: const Icon(Icons.filter_list),
            label: const Text('Filtros'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filtros'),
          content: const Text('Aquí irían los filtros'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildConsultoriosList() {
    return ListView.builder(
      itemCount: consultorios.length,
      itemBuilder: (context, index) {
        final consultorio = consultorios[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ConsultorioDetailScreen(consultorio: consultorio),
              ),
            );
          },
          child: _buildConsultorioCard(context, consultorio),
        );
      },
    );
  }

  Widget _buildConsultorioCard(BuildContext context, Consultorio consultorio) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            consultorio.imagen,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      consultorio.nombre,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${consultorio.precio.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'por hora',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 16.0),
                    const SizedBox(width: 4.0),
                    Text(
                      '${consultorio.capacidad} personas',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  consultorio.descripcion,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: consultorio.amenidades
                      .map((amenidad) => _buildTag(amenidad))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Chip(label: Text(label), backgroundColor: Colors.grey.shade200);
  }
}
