import 'package:chat_app_flutter/res/components/my_shadow.dart';
import 'package:chat_app_flutter/res/custom_design/cousto_clip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HexagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final point = Size(10, 7);
    final radius = 12.0;

    final path = Path();
    //path.moveTo(size.width * 0.25 + 2, 0);
    path.lineTo(point.width, point.height);
    path.lineTo(point.width,
        size.height - radius > 0 ? size.height - radius : size.height);

    path.quadraticBezierTo(
        point.width,
        size.height,
        point.width + radius < size.width ? point.width + radius : size.width,
        size.height);

    //c

    path.lineTo(size.width - radius > 0 ? size.width - radius : size.width,
        size.height);
    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - radius > 0 ? size.height - radius : size.height);
    //d

    path.lineTo(size.width, radius > size.height ? size.height : radius);
    path.quadraticBezierTo(size.width, 0,
        size.width - radius < 0 ? size.width : size.width - radius, 0);
    //path.lineTo(0, size.height * 0.5);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MessageShape extends StatelessWidget {
  final Widget child;
  final double elevation;
  final Color shadowColor;
  final Color backgroundColor;
  final double angel;

  const MessageShape({
    Key? key,
    required this.child,
    this.elevation = 5.0,
    this.shadowColor = Colors.black,
    this.backgroundColor = Colors.lightBlue,
    this.angel = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //CoutoClip coutoClip = CoutoClip();
    HexagonalClipper coutoClip = HexagonalClipper();

    return Material(
      //clipBehavior: Clip.antiAlias,
      elevation: elevation,
      shadowColor: shadowColor,
      color: backgroundColor,
      borderOnForeground: false,
      shape: HexagonalShapeBorder(),
      child: ClipPath(
        clipper: coutoClip,
        child: child,
      ),
    );
  }
}

class HexagonalShapeBorder extends ShapeBorder {
  //CoutoClip coutoClip = CoutoClip();
  HexagonalClipper coutoClip = HexagonalClipper();

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(4);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return coutoClip.getClip(
        rect.size); //HexagonalClipper().getClip(rect.size).shift(rect.topLeft);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}
