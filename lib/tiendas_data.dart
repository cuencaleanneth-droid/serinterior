class Tienda {
  final String ciudad;
  final String nombre;
  final String direccion;
  final String telefono;
  final String imagen;


  Tienda({
    required this.ciudad,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.imagen,
    
  });
}

final List<Tienda> tiendas = [
  Tienda(
    ciudad: 'Barranquilla',
    nombre: 'Mall plaza Buenavista',
    direccion: 'Mallplaza Buenavista-Loc LS-054B',
    telefono: 'Tel: +57 305 2891184',
    imagen: 'assets/images/tienda1.png',
   
  ),
  Tienda(
    ciudad: 'Barranquilla',
    nombre: 'CC Portal del Prado',
    direccion: 'CC Portal del Prado Loc 107',
    telefono: '', // No phone in image
    imagen: 'assets/images/tienda2.png',
    
  ),
  Tienda(
    ciudad: 'Barranquilla',
    nombre: 'CC Villa Country Barranquilla',
    direccion: 'CC Villa Country Loc 103',
    telefono: 'Tel:+57 319 7835821',
    imagen: 'assets/images/tienda3.png',
    
  ),
  Tienda(
    ciudad: 'Medellín',
    nombre: 'CC Unicentro Medellín',
    direccion: 'CC Unicentro Loc 2-332',
    telefono: 'Tel: +57 319 6848093',
    imagen: 'assets/images/tienda4.png',
    
  ),
  Tienda(
    ciudad: 'Medellín',
    nombre: 'CC Oviedo Medellín',
    direccion: 'CC Oviedo Loc 117',
    telefono: 'Tel:+57 319 5036973',
    imagen: 'assets/images/tienda5.png',
   
  ),
  Tienda(
    ciudad: 'Cali',
    nombre: 'CC Unicentro Cali',
    direccion: 'CC Unicentro local 321',
    telefono: 'Tel: +57 319 4735520',
    imagen: 'assets/images/tienda6.png',
    
  ),
];
