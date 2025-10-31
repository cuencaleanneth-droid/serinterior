import 'package:flutter/material.dart';
import 'package:myapp/data/terapeutas_data.dart'; // Importa la fuente de datos central
import 'package:myapp/menu.dart';
import 'package:myapp/reservas_data.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final Widget? card;

  ChatMessage({required this.text, required this.isUser, this.card});
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
    _addBotMessage("Hola, somos Ser Interior. ¿En qué podemos ayudarte hoy?");
  }

  void _addBotMessage(String text, {Widget? card}) {
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: false, card: card));
    });
    _scrollToBottom();
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });

    _textController.clear();
    _scrollToBottom();
    _getBotResponse(text);
  }

  void _getBotResponse(String userMessage) {
    Future.delayed(const Duration(milliseconds: 600), () {
      String lowerCaseMessage = userMessage.toLowerCase();
      Consultorio? mentionedConsultorio;
      try {
        mentionedConsultorio = consultorios.firstWhere((c) => lowerCaseMessage.contains(c.nombre.toLowerCase().split(' ').last));
      } catch (e) {
        // No se encontró
      }

      if (lowerCaseMessage.contains('reservar')) {
        _handleReservation(lowerCaseMessage);
        return;
      }
      if (lowerCaseMessage.contains('psicologo') || lowerCaseMessage.contains('terapeuta') || lowerCaseMessage.contains('coach')) {
        _handleTherapistSearch(lowerCaseMessage);
        return;
      }
      if (mentionedConsultorio != null) {
        _handleConsultorioQuery(lowerCaseMessage, mentionedConsultorio);
        return;
      }
      if (lowerCaseMessage.contains('consultorios') || lowerCaseMessage.contains('espacio')) {
        _addBotMessage("¡Claro! Aquí tienes nuestros espacios:");
        for (var consultorio in consultorios) {
          _addBotMessage("", card: _buildConsultorioCard(consultorio));
        }
        return;
      }
      if (lowerCaseMessage.contains('productos')) {
        _addBotMessage("Actualmente nos enfocamos en ofrecer espacios y conectar con terapeutas. No manejamos una línea de productos.");
        return;
      }
      if (lowerCaseMessage.contains('medellín') || lowerCaseMessage.contains('cali') || lowerCaseMessage.contains('ubicados')) {
        _addBotMessage("Todos nuestros consultorios están en El Poblado, Medellín. Para recibir la dirección exacta, contáctanos al WhatsApp +57 305 222 4894.");
        return;
      }
      if (lowerCaseMessage.contains('hola') || lowerCaseMessage.contains('buenos días')) {
        _addBotMessage("¡Hola! ¿Cómo puedo ayudarte hoy?");
        return;
      }
      _addBotMessage("No te he entendido bien. Prueba preguntando, por ejemplo: '¿Qué psicólogos hay en Armonía?'");
    });
  }

  void _handleReservation(String message) {
    Consultorio? targetConsultorio;
    try {
      targetConsultorio = consultorios.firstWhere((c) => message.contains(c.nombre.toLowerCase().split(' ').last));
    } catch (e) {
      // No se encontró
    }

    String response = targetConsultorio != null
        ? "¡Excelente elección! Para reservar el ${targetConsultorio.nombre},"
        : "Para realizar una reserva,";
    response += " por favor contáctanos vía WhatsApp al +57 300 123 4567.";
    _addBotMessage(response);
  }

  void _handleTherapistSearch(String message) {
    List<Terapeuta> results = [];
    String specialty = "";

    if (message.contains('psicologo')) specialty = 'Psicólogos';
    else if (message.contains('coach')) specialty = 'Coach Personal';
    else if (message.contains('terapeuta')) specialty = 'Terapeutas Holísticos';

    if (specialty.isNotEmpty) {
      results = terapeutas.where((t) => t.especialidad == specialty).toList();
    } else {
      results = List.from(terapeutas);
    }

    Consultorio? mentionedConsultorio;
    try {
      mentionedConsultorio = consultorios.firstWhere((c) => message.contains(c.nombre.toLowerCase().split(' ').last));
    } catch (e) {
      // No se encontró
    }

    if (mentionedConsultorio != null) {
      final consultorioNombre = mentionedConsultorio.nombre;
      results = results.where((t) => t.consultorio == consultorioNombre).toList();
    }

    if (results.isEmpty) {
      _addBotMessage("No encontré especialistas que coincidan con tu búsqueda. Intenta de nuevo.");
    } else {
      _addBotMessage("Encontré estos especialistas para ti:");
      for (var terapeuta in results) {
        _addBotMessage("${terapeuta.nombre} (${terapeuta.subEspecialidad}) - Atiende en ${terapeuta.consultorio}. Precio: \$${terapeuta.precio} COP.");
      }
    }
  }

  void _handleConsultorioQuery(String message, Consultorio consultorio) {
    String response;
    if (message.contains('precio') || message.contains('en cuanto')) {
      response = 'El precio del ${consultorio.nombre} es de \$${consultorio.precio} COP por hora.';
    } else if (message.contains('disponibilidad') || message.contains('hora')) {
      response = 'Para verificar la disponibilidad del ${consultorio.nombre}, contáctanos al WhatsApp +57 300 123 4567.';
    } else if (message.contains('capacidad')) {
      response = 'La capacidad del ${consultorio.nombre} es de ${consultorio.capacidad} personas.';
    } else if (message.contains('amenidades')) {
      response = 'Las amenidades del ${consultorio.nombre} son: ${consultorio.amenidades.join(', ')}.';
    } else {
      response = 'Estás viendo el ${consultorio.nombre}. ${consultorio.descripcion}';
    }
    _addBotMessage(response);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut,);
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
        ],
      ),
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
                if (message.card != null) return message.card!;
                return _buildMessageBubble(message);
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
