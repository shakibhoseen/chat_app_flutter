import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  final Widget child;
  final double sigmaX = 30;
  final double sigmaY = 30;
  const Blur({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child,
      ),
    );
  }
}
