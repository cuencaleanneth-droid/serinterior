import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Testimonio {
  final String texto;
  final String autor;
  final String rol;
  final int calificacion;

  Testimonio({
    required this.texto,
    required this.autor,
    required this.rol,
    required this.calificacion,
  });
}

class TestimoniosSection extends StatefulWidget {
  const TestimoniosSection({super.key});

  @override
  State<TestimoniosSection> createState() => _TestimoniosSectionState();
}

class _TestimoniosSectionState extends State<TestimoniosSection> {
  final _formKey = GlobalKey<FormState>();
  final _autorController = TextEditingController();
  final _rolController = TextEditingController();
  final _textoController = TextEditingController();
  double _calificacion = 5.0;

  final List<Testimonio> _testimonios = [
    Testimonio(
      texto:
          "\"Ser Interior cambió mi vida. Encontré el terapeuta perfecto y el proceso fue increíble.\"",
      autor: "María González",
      rol: "Cliente",
      calificacion: 5,
    ),
    Testimonio(
      texto:
          "\"Una plataforma profesional que me permite conectar mejor con mis pacientes.\"",
      autor: "Dr. Carlos Ruiz",
      rol: "Psicólogo",
      calificacion: 5,
    ),
    Testimonio(
      texto:
          "\"Los espacios de Ser Interior son perfectos para mis sesiones de coaching.\"",
      autor: "Ana Martínez",
      rol: "Coach Personal",
      calificacion: 5,
    ),
  ];

  void _submitTestimonio() {
    if (_formKey.currentState!.validate()) {
      final nuevoTestimonio = Testimonio(
        autor: _autorController.text,
        rol: _rolController.text,
        texto: _textoController.text,
        calificacion: _calificacion.round(),
      );
      setState(() {
        _testimonios.add(nuevoTestimonio);
      });
      _autorController.clear();
      _rolController.clear();
      _textoController.clear();
      setState(() {
        _calificacion = 5.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "Deja tu testimonio",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _autorController,
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _rolController,
                  decoration: const InputDecoration(
                    labelText: "Rol (e.g., Cliente, Psicólogo)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu rol';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _textoController,
                  decoration: const InputDecoration(
                    labelText: "Tu testimonio",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu testimonio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                RatingStars(
                  value: _calificacion,
                  onValueChanged: (v) {
                    setState(() {
                      _calificacion = v;
                    });
                  },
                  starCount: 5,
                  starSize: 35,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: false,
                  valueLabelVisibility: true,
                  animationDuration: const Duration(milliseconds: 1000),
                  valueLabelPadding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 8,
                  ),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.amber,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitTestimonio,
                  child: const Text("Enviar Testimonio"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Lo que dicen nuestros usuarios",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Testimonios reales de nuestra comunidad",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Column(
            children: _testimonios
                .map((testimonio) => _buildTestimonioCard(testimonio))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonioCard(Testimonio testimonio) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(38),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              testimonio.calificacion,
              (index) => const Icon(Icons.star, color: Colors.amber, size: 24),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            testimonio.texto,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            testimonio.autor,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            testimonio.rol,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
