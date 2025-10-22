class Consultorio {
  final String nombre;
  final String descripcion;
  final String imagen;
  final double precio;
  final int capacidad;
  final List<String> amenidades;

  Consultorio({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.precio,
    required this.capacidad,
    required this.amenidades,
  });
}

final List<Consultorio> consultorios = [
  Consultorio(
    nombre: 'Consultorio Gratitud',
    descripcion:
        'Espacio íntimo con camilla y baño privado, ideal para terapias individuales.',
    imagen: 'assets/images/consultorio.png',
    precio: 50000,
    capacidad: 2,
    amenidades: ['Camilla', 'Baño privado', 'Iluminación natural'],
  ),
  Consultorio(
    nombre: 'Consultorio Armonía',
    descripcion:
        'Salón amplio y luminoso, perfecto para talleres y terapias grupales.',
    imagen: 'assets/images/salon.png',
    precio: 80000,
    capacidad: 10,
    amenidades: ['Sillas y cojines', 'Equipo de sonido', 'Aire acondicionado'],
  ),
  Consultorio(
    nombre: 'Consultorio Calma',
    descripcion: 'Consultorio acogedor para terapias de pareja o familia.',
    imagen: 'assets/images/consultorio2.png',
    precio: 60000,
    capacidad: 4,
    amenidades: ['Sofá cómodo', 'Mesa de centro', 'Dispensador de agua'],
  ),
];
