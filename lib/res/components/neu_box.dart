import 'package:flutter/material.dart';

extension Neumorphism on Widget {
  addNeumorphism({BoxShape boxShape = BoxShape.rectangle}) {
    return Container(
      decoration:
          boxShape == BoxShape.circle ? customCircle() : customRectangle(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: this,
        ),
      ),
    );
  }
}

BoxDecoration customCircle() {
  return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey[300],
      boxShadow: [
        // darker shadow on bottom right
        BoxShadow(
          color: Colors.grey.shade500,
          blurRadius: 15,
          offset: const Offset(5, 5),
        ),
        //lighter shadow on top left
        const BoxShadow(
          color: Colors.white,
          blurRadius: 15,
          offset: Offset(-5, -5),
        )
      ]);
}

BoxDecoration customRectangle() {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        // darker shadow on bottom right
        BoxShadow(
          color: Colors.grey.shade500,
          blurRadius: 15,
          offset: const Offset(5, 5),
        ),
        //lighter shadow on top left
        const BoxShadow(
          color: Colors.white,
          blurRadius: 15,
          offset: Offset(-5, -5),
        )
      ]);
}
