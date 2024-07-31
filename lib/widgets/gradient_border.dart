import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;

  const GradientBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1), // Border width
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffb81736),
            Color(0xff281537),
            Color(0xffb81736),
          ], // Gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        color: Colors.white, // Background color
        child: child,
      ),
    );
  }
}
