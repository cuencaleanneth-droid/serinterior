import 'package:flutter/material.dart';
import 'package:myapp/menu.dart';
import 'package:myapp/reservas_data.dart';

// Clase para representar un mensaje en el chat
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Mensaje inicial del bot
    _addBotMessage(
        "Hola, somos Ser Interior. Escribe 'consultorios' para ver las opciones disponibles.");
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: false));
    });
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    // Añadir mensaje del usuario
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });

    _textController.clear();
    _scrollToBottom();

    // Simular respuesta del bot
    _getBotResponse(text);
  }

  void _getBotResponse(String userMessage) {
    Future.delayed(const Duration(milliseconds: 500), () {
      String botResponse;
      if (userMessage.toLowerCase().contains('consultorios')) {
        botResponse = "¡Claro! Aquí tienes nuestros consultorios:";
        setState(() {
          _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
        });

        // Mostrar los consultorios como tarjetas
        for (var consultorio in consultorios) {
          setState(() {
            _messages.insert(0,
                ChatMessage(text: "", isUser: false)); // Placeholder for card
          });
        }
      } else if (userMessage.toLowerCase().contains('hola')) {
        botResponse = "¡Hola! ¿Cómo puedo ayudarte?";
        setState(() {
          _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
        });
      } else {
        botResponse =
            "No entiendo. Por favor, escribe 'consultorios' para ver las opciones.";
        setState(() {
          _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
        });
      }
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo2.png'),
            radius: 30,
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ]),
      endDrawer: const Menu(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                // Si el mensaje es un placeholder, muestra la tarjeta del consultorio
                if (message.text.isEmpty && !message.isUser) {
                  // Encuentra el consultorio correspondiente (esto es una simplificación)
                  int consultorioIndex = _messages
                      .where((m) => m.text.isEmpty && !m.isUser)
                      .toList()
                      .indexOf(message);
                  if (consultorioIndex < consultorios.length) {
                    final consultorio = consultorios[consultorioIndex];
                    return _buildConsultorioCard(consultorio);
                  } else {
                    return const SizedBox.shrink(); // No debería pasar
                  }
                } else {
                  return _buildMessageBubble(message);
                }
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildConsultorioCard(Consultorio consultorio) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                consultorio.imagen,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              consultorio.nombre,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(consultorio.descripcion),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final align =
        message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = message.isUser ? Colors.blue.shade100 : Colors.grey.shade200;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(message.text, style: const TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 32,
          color: Colors.black.withOpacity(0.08),
        ),
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: "Escribe tu mensaje...",
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage, // Esto ahora funciona
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
