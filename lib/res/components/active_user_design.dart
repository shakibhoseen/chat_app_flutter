import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveUserDesign {
  static Widget activeUserContainer(bool isActive, {Widget? childs}) {
    return Container(
      decoration: _getDecoration(isActive),
      child: childs ??
          SizedBox(
            height: 10,
            width: 10,
          ),
    );
  }

  static Decoration _getDecoration(bool isActive) {
    return isActive
        ? BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
            border: Border.all(
                color: Colors.white, style: BorderStyle.solid, width: 2),
            boxShadow: MyShadow.boxShadow5(),
          )
        : BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 107, 3, 3),
            border: Border.all(
                color: Colors.white, style: BorderStyle.solid, width: 2),
            boxShadow: MyShadow.boxShadow5(),
          );
  }
}
