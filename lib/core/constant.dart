import 'package:flutter/material.dart';

Widget H(double height) {
  return SizedBox(
    height: height,
  );
}

Widget W(double width) {
  return SizedBox(
    width: width,
  );
}

Color fillColor = const Color.fromARGB(255, 173, 198, 173);
Color cardColor = const Color.fromARGB(255, 238, 237, 232);
Color white = Colors.white;
Color black = Colors.black;
Color a = const Color(0xffb81736);
Color b = const Color(0xff281537);
Color c = const Color.fromARGB(255, 176, 173, 173);
double fontSize = 16;

final List<IconData> iconsList = [
  Icons.person,
  Icons.tv,
  Icons.woman,
  Icons.list
];
