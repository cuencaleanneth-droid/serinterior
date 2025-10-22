import 'package:flutter/material.dart';
import 'package:myapp/menu.dart';
import 'package:myapp/tiendas_data.dart';

class TiendasScreen extends StatelessWidget {
  const TiendasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0), // Lighter gray background
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount;
                  double aspectRatio = 0.6; // Made cards taller

                  if (constraints.maxWidth > 1200) {
                    crossAxisCount = 4;
                  } else if (constraints.maxWidth > 800) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth > 600) {
                    crossAxisCount = 2;
                    aspectRatio = 0.65; // Adjust for tablet
                  } else {
                    crossAxisCount = 1;
                    aspectRatio = 0.6; // Adjust for mobile
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tiendas.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: aspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      return _buildTiendaCard(tiendas[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF17B2C3),
            child: Icon(Icons.storefront, color: Colors.white, size: 30),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nuestras Tiendas Espirituales',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Lugares donde nos puedes encontrar y comprar productos para tus prácticas.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTiendaCard(Tienda tienda) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5, // Increased flex for the image
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                tienda.imagen,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 4, // Decreased flex for the content
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tienda.ciudad,
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tienda.nombre,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tienda.direccion,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tienda.telefono,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const Spacer(), // Pushes the button to the bottom
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6CACDE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        tienda.botonTexto,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
