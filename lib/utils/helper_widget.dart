import 'package:flutter/material.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHoriztalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget customVerticalDivider({Color color = Colors.grey}) {
  return VerticalDivider(
    thickness: 1,
    color: color,
  );
}
