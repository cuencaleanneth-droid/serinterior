import 'package:flutter/material.dart';
import 'package:myapp/reservas_data.dart';

class ConsultorioDetailScreen extends StatelessWidget {
  final Consultorio consultorio;

  const ConsultorioDetailScreen({super.key, required this.consultorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(consultorio.nombre)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              consultorio.imagen,
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consultorio.nombre,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\$${consultorio.precio.toStringAsFixed(0)} por hora',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    consultorio.descripcion,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Amenidades',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: consultorio.amenidades
                        .map(
                          (amenidad) => Chip(
                            label: Text(amenidad),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
