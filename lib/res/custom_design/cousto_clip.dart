
import 'package:flutter/cupertino.dart';

class CoutoClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double percent = 29;
    double calculate = size.width* (percent/100);
    double topLeftX = 0+ calculate;
    double topRightX = size.width - calculate;

    Path path = Path();
    path.moveTo(topLeftX, 0);
    path.lineTo(0, size.height-calculate);
    path.quadraticBezierTo((size.width/2), (size.height-2), size.width, size.height-calculate);
    //path.lineTo(size.width, size.height);
    path.lineTo(topRightX, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
    //throw UnimplementedError();
  }

}