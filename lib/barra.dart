import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/inicio.dart';
import 'package:myapp/terapeutas.dart';
import 'package:myapp/reservas.dart';
import 'package:myapp/chat.dart';

class BarraNavegacion extends StatefulWidget {
  const BarraNavegacion({super.key});

  @override
  BarraNavegacionState createState() => BarraNavegacionState();
}

class BarraNavegacionState extends State<BarraNavegacion> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Inicio(),
    TerapeutasScreen(),
    ReservasScreen(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: const Color(0xFF000000).withAlpha(26),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.pink,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.pink.withAlpha(26),
              color: const Color(0xFF333333),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Inicio',
                ),
                GButton(
                  icon: Icons.people,
                  text: 'Terapeutas',
                ),
                GButton(
                  icon: Icons.calendar_today,
                  text: 'Reservas',
                ),
                GButton(
                  icon: Icons.chat_bubble_outline,
                  text: 'Chat',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
