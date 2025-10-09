import 'package:flutter/material.dart';

class ReservasScreen extends StatelessWidget {
  const ReservasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildHeader(context),
          _buildTabs(),
          _buildConsultorioCard(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reserva tu Espacio Ideal',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Consultorios y salones equipados en nuestra casa Ser Interior',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ver Espacios'),
          ),
          const SizedBox(width: 8.0),
          TextButton(
            onPressed: () {},
            child: const Text('Mis Reservas'),
          ),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            label: const Text('Filtros'),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultorioCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/consultorio.png', // Placeholder
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
                      'Consultorio Gratitud',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$50.000',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'por hora',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 16.0),
                    const SizedBox(width: 4.0),
                    Text(
                      '2 personas',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Espacio íntimo con camilla y baño privado, ideal para terapias individuales',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    _buildTag('Camilla'),
                    _buildTag('Baño privado'),
                    _buildTag('Iluminación natural'),
                    ActionChip(
                      label: const Text('+1 más'),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
