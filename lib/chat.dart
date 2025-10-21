import 'package:flutter/material.dart';
import 'package:myapp/menu.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: <Widget>[
          // This is the header that was part of the old AppBar
          // You might want to display this information differently now
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                const CircleAvatar(
                  // backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/women/65.jpg>"),
                  maxRadius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Dra. María Elena Rodríguez",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Psicóloga Clínica",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.videocam, color: Colors.black54),
                const SizedBox(width: 20),
                const Icon(Icons.phone, color: Colors.black54),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (Colors.grey.shade200),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        "Hola, ¿cómo te has sentido después de nu...",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  child: const Icon(Icons.send, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
