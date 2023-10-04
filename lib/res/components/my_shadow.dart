import 'package:flutter/material.dart';
class MyShadow {




static List <BoxShadow> boxShadow1 (){
  return [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),

  ];
}

static List <BoxShadow> boxShadow2 (){
  return [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),

  ];
}
static List <BoxShadow> boxShadow3 (){
  return [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),

  ];
}

static List <BoxShadow> boxShadow4 (){
  return [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 10,
      offset: Offset(0, 6),
    ),

  ];
}
static List <BoxShadow> boxShadow5 (){
  return [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 12,
      offset: Offset(0, 8),
    ),

  ];
}
static List <BoxShadow> boxShadow6 (){
  return [
    const BoxShadow(
      color: Color.fromRGBO(14, 31, 53, 0.08),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
    const BoxShadow(
      color: Color.fromRGBO(14, 31, 53, 0.12),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),

  ];
}


}