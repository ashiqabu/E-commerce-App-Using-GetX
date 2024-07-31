import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final void Function() onPressed;
  final double width;
  final double height;

  const GradientButton({
    super.key,
    required this.child,
    required this.gradient,
    required this.onPressed,
    this.width = 200,  // Default width
    this.height = 50,  // Default height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(8)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Make button transparent
            shadowColor: Colors.transparent, // Remove shadow
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
