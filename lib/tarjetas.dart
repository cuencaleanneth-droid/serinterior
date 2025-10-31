import 'package:flutter/material.dart';
import 'package:myapp/chat.dart';
import 'package:myapp/reservas.dart';
import 'package:myapp/terapeutas.dart';
import 'package:myapp/tiendas.dart';

class Feature {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Widget? destinationScreen;

  const Feature({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.destinationScreen,
  });
}

// CORRECCIÓN: Se añaden las pantallas de destino a las tarjetas.
final List<Feature> _features = [
  const Feature(
    title: 'Terapeutas Profesionales',
    subtitle: 'Conecta con especialistas certificados.',
    icon: Icons.people,
    iconColor: Color(0xFF6A1B9A), // Púrpura
    destinationScreen: Terapeutas(), // Navega a la pantalla de Terapeutas
  ),
  const Feature(
    title: 'Espacios',
    subtitle: 'Encuentra lugares para tus sesiones.',
    icon: Icons.calendar_today,
    iconColor: Color(0xFF1E88E5), // Azul
    destinationScreen: ReservasScreen(), // Navega a la pantalla de Reservas
  ),
  const Feature(
    title: 'Chat Seguro',
    subtitle: 'Comunícate con total privacidad.',
    icon: Icons.chat_bubble_outline,
    iconColor: Color(0xFF43A047), // Verde
    destinationScreen: ChatScreen(), // Navega a la pantalla de Chat
  ),
  const Feature(
    title: 'Nuestras Tiendas Espirituales',
    subtitle: 'Encuéntranos y cómpranos nuestros productos.',
    icon: Icons.store,
    iconColor: Color(0xFF00ACC1), // Cian
    destinationScreen: TiendasScreen(),
  ),
];

class FeatureCards extends StatelessWidget {
  const FeatureCards({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _features.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final feature = _features[index];
        return GestureDetector(
          onTap: () {
            if (feature.destinationScreen != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => feature.destinationScreen!,
                ),
              );
            }
          },
          child: FeatureCard(
            icon: feature.icon,
            iconColor: feature.iconColor,
            title: feature.title,
            subtitle: feature.subtitle,
          ),
        );
      },
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFFCE4EC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFCE4EC).withAlpha(204), // 80% opacity
            spreadRadius: 4,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Icon(icon, color: Colors.white, size: 30.0),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF444444),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
