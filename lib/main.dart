
import 'package:flutter/material.dart';
import 'package:myapp/barra.dart';

void main() {
  runApp(const SerInteriorApp());
}

class SerInteriorApp extends StatelessWidget {
  const SerInteriorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ser Interior',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BarraNavegacion(),
      debugShowCheckedModeBanner: false,
    );
  }
}
