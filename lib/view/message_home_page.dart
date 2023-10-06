import 'package:flutter/material.dart';


class MessageHomePage extends StatefulWidget {
  final String myId, otherId;
  const MessageHomePage( {super.key, required this.myId, required this.otherId});

  @override
  State<MessageHomePage> createState() => _MessageHomePageState();
}

class _MessageHomePageState extends State<MessageHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      
    ),
      body: Column(
        children: [
          Text('message page my Id ${widget.myId}'),
        ],
      ),
    );
  }
}
