import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/reservas_data.dart';
import 'package:myapp/mis_reservas_screen.dart';
import 'package:myapp/consultorio_detail_screen.dart';
import 'package:myapp/menu.dart';
import 'dart:math';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});

  @override
  ReservasScreenState createState() => ReservasScreenState();
}

class ReservasScreenState extends State<ReservasScreen> {
  bool _showMisReservas = false;
  String _sortOrder = 'default';
  RangeValues? _selectedPriceRange;
  double _minPrice = 0;
  double _maxPrice = 0;
  final GlobalKey _filterButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializePriceRange();
  }

  void _initializePriceRange() {
    if (consultorios.isNotEmpty) {
      final prices = consultorios.map((c) => c.precio).toList();
      _minPrice = prices.reduce(min).toDouble();
      _maxPrice = prices.reduce(max).toDouble();
      _selectedPriceRange = RangeValues(_minPrice, _maxPrice);
    } else {
      _minPrice = 0;
      _maxPrice = 100000; // Default max price
      _selectedPriceRange = const RangeValues(0, 100000);
    }
  }

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
              'Encuentra tu Espacio Ideal',
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
          const Spacer(),
          OutlinedButton.icon(
            key: _filterButtonKey,
            onPressed: () => _showFilterMenu(context),
            icon: const Icon(Icons.filter_list),
            label: const Text('Filtros'),
          ),
        ],
      ),
    );
  }

  void _showFilterMenu(BuildContext context) {
    final RenderBox button =
        _filterButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final formatCurrency = NumberFormat("\$ #,##0", "es_CO");
    RangeValues? currentRange = _selectedPriceRange;

    showMenu<void>(
      context: context,
      position: position.shift(const Offset(0, 40)),
      items: [
        PopupMenuItem(
          enabled: false,
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Filtrar por Precio',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    RangeSlider(
                      values: currentRange ?? RangeValues(_minPrice, _maxPrice),
                      min: _minPrice,
                      max: _maxPrice,
                      divisions: 20,
                      activeColor: const Color.fromRGBO(128, 90, 213, 1),
                      inactiveColor: Colors.grey.shade300,
                      labels: RangeLabels(
                        formatCurrency.format(currentRange?.start ?? _minPrice),
                        formatCurrency.format(currentRange?.end ?? _maxPrice),
                      ),
                      onChanged: (values) {
                        setDialogState(() {
                          currentRange = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatCurrency
                            .format(currentRange?.start ?? _minPrice)),
                        Text(formatCurrency
                            .format(currentRange?.end ?? _maxPrice)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedPriceRange = currentRange;
                          });
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(128, 90, 213, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('FILTRO'),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildConsultoriosList() {
    List<Consultorio> filteredConsultorios = List.from(consultorios);

    if (_selectedPriceRange != null) {
      filteredConsultorios = filteredConsultorios.where((c) {
        return c.precio >= _selectedPriceRange!.start &&
            c.precio <= _selectedPriceRange!.end;
      }).toList();
    }

    if (_sortOrder == 'price_asc') {
      filteredConsultorios.sort((a, b) => a.precio.compareTo(b.precio));
    }

    return ListView.builder(
      itemCount: filteredConsultorios.length,
      itemBuilder: (context, index) {
        final consultorio = filteredConsultorios[index];
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
    final formatCurrency = NumberFormat("\$ #,##0", "es_CO");

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
                    Row(
                      children: [
                        Text(
                          formatCurrency.format(consultorio.precio),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(width: 4.0),
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
