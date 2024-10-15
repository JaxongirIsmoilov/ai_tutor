import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  TextEditingController promptController = TextEditingController();
  ScrollController controller = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  final List<ModelMessage> prompt = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.2).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _colorAnimation = ColorTween(begin: Colors.indigoAccent, end: Colors.blueAccent).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    final message = promptController.text;
    setState(() {
      promptController.clear();
      prompt.add(ModelMessage(
        isPrompt: true,
        message: message,
        time: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.withOpacity(0.3),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "AI Tutor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: prompt.length,
              itemBuilder: (context, index) {
                final message = prompt[index];
                return UserPrompt(
                  isPrompt: message.isPrompt,
                  message: message.message,
                  date: DateFormat('hh:mm a').format(message.time),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: TextField(
                    maxLines: null,
                    controller: promptController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Ask anything you want",
                      hintStyle: const TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onLongPress: () {
                    _animationController.forward();
                    // Start recording logic can go here
                  },
                  onLongPressUp: () {
                    _animationController.reverse();
                    // Stop recording logic can go here
                  },
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _colorAnimation.value,
                            ),
                            child: const CircleAvatar(
                              child: Icon(
                                Icons.mic,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container UserPrompt({
    required bool isPrompt,
    required String message,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isPrompt ? 80 : 15,
        right: isPrompt ? 15 : 80,
      ),
      decoration: BoxDecoration(
        color: isPrompt ? Colors.green : Colors.indigo,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isPrompt ? const Radius.circular(20) : Radius.zero,
          bottomRight: isPrompt ? Radius.zero : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ModelMessage {
  final bool isPrompt;
  final String message;
  final DateTime time;

  ModelMessage({required this.isPrompt, required this.message, required this.time});
}
