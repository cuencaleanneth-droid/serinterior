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
    _addBotMessage("Hola, somos Ser Interior, ¿En qué podemos ayudarte?");
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

    // El bot procesa el mensaje y responde
    _getBotResponse(text);
  }

  void _getBotResponse(String userMessage) {
    Future.delayed(const Duration(milliseconds: 500), () {
      String botResponse;
      String lowerCaseMessage = userMessage.toLowerCase();

      // Busca si se menciona un consultorio específico
      Consultorio? mentionedConsultorio;
      for (var c in consultorios) {
        if (lowerCaseMessage.contains(c.nombre.toLowerCase())) {
          mentionedConsultorio = c;
          break;
        }
      }

      if (mentionedConsultorio != null) {
        // Si se menciona un consultorio, responde a preguntas específicas sobre él
        if (lowerCaseMessage.contains('precio')) {
          botResponse = 'El precio del ${mentionedConsultorio.nombre} es de \$${mentionedConsultorio.precio} COP por hora.';
        } else if (lowerCaseMessage.contains('disponibilidad') || lowerCaseMessage.contains('hora') || lowerCaseMessage.contains('disponible')) {
          botResponse = 'Para verificar la disponibilidad y agendar una cita para el ${mentionedConsultorio.nombre}, por favor comunícate directamente con nosotros al WhatsApp +57 300 123 4567. Estaremos felices de ayudarte.';
        } else if (lowerCaseMessage.contains('capacidad')) {
            botResponse = 'La capacidad del ${mentionedConsultorio.nombre} es de ${mentionedConsultorio.capacidad} personas.';
        } else if (lowerCaseMessage.contains('amenidades')) {
            botResponse = 'Las amenidades del ${mentionedConsultorio.nombre} son: ${mentionedConsultorio.amenidades.join(', ')}.';
        } else {
          // Si solo se menciona el nombre, da la descripción general
          botResponse = 'Has seleccionado el ${mentionedConsultorio.nombre}. ${mentionedConsultorio.descripcion} ¿Qué más te gustaría saber? Puedes preguntar por su precio, capacidad o disponibilidad.';
        }
         setState(() {
          _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
        });

      } else if (lowerCaseMessage.contains('consultorios')) {
        botResponse = "¡Claro! Aquí tienes nuestros consultorios:";
        setState(() {
          _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
        });

        // Muestra los consultorios como tarjetas
        for (var consultorio in consultorios) {
          setState(() {
            _messages.insert(0, ChatMessage(text: "", isUser: false)); // Placeholder para la tarjeta
          });
        }
      } else if (lowerCaseMessage.contains('hola')) {
        botResponse = "¡Hola! ¿Cómo puedo ayudarte? Puedes preguntar por nuestros consultorios.";
         setState(() {
          _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
        });
      } else {
        botResponse = "No te entiendo muy bien. Puedes preguntarme por 'consultorios', o si quieres saber algo específico, pregunta por el nombre del consultorio y qué quieres saber (ej: 'precio del consultorio Armonía').";
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
                 if (message.text.isEmpty && !message.isUser) {
                    int consultorioIndex = _messages.where((m) => m.text.isEmpty && !m.isUser).toList().indexOf(message);
                     if (consultorioIndex < consultorios.length) {
                      final consultorio = consultorios.reversed.toList()[consultorioIndex];
                       return _buildConsultorioCard(consultorio);
                    } else {
                      return const SizedBox.shrink();
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
    final align = message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
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
                onPressed: _sendMessage,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
