import 'package:flutter/material.dart';

class WhatsAppMessageItem extends StatelessWidget {
  final String messageText;
  final bool isMe;

  const WhatsAppMessageItem({required this.messageText, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ClipPath(
        clipper: MyClipper(isMe: true),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.green : Colors.grey, // Set your desired colors
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                messageText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final bool isMe;

  MyClipper({required this.isMe});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (isMe) {
      path.lineTo(size.width - 10, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 10);
      path.lineTo(size.width, size.height - 10);
      path.quadraticBezierTo(
          size.width, size.height, size.width - 10, size.height);
    } else {
      // Define clip path for messages received from someone else if needed
    }

    path.lineTo(10, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 10);
    path.lineTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
