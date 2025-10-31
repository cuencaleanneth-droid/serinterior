
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
  final int precio;

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

final List<Terapeuta> terapeutas = [
  Terapeuta(
    nombre: 'Dra. María Elena Rodríguez',
    especialidad: 'Psicólogos',
    subEspecialidad: 'Psicología Clínica y Terapia Cognitiva',
    descripcion:
        'Especialista en terapia cognitivo-conductual con enfoque en ansiedad y depresión.',
    imagen: 'assets/images/maria.png',
    calificacion: 4.9,
    resenas: 127,
    aniosExperiencia: 12,
    consultorio: 'Consultorio Gratitud',
    precio: 80000,
  ),
  Terapeuta(
    nombre: 'Héctor García',
    especialidad: 'Coach Personal',
    subEspecialidad: 'Life Coach y Desarrollo Personal',
    descripcion: 'Coach certificado especializado en liderazgo y emprendimiento.',
    imagen: 'assets/images/foto2.png',
    calificacion: 4.9,
    resenas: 99,
    aniosExperiencia: 11,
    consultorio: 'Consultorio Armonía',
    precio: 60000,
  ),
  Terapeuta(
    nombre: 'Carlos López',
    especialidad: 'Terapeutas Holísticos',
    subEspecialidad: 'Terapia de Reiki y Sanación Energética',
    descripcion:
        'Maestro de Reiki con amplia experiencia en la sanación y el equilibrio de los chakras.',
    imagen: 'assets/images/foto3.png',
    calificacion: 4.8,
    resenas: 98,
    aniosExperiencia: 10,
    consultorio: 'Consultorío Calma',
    precio: 60000,
  ),
];
