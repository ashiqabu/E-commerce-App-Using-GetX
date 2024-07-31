import 'package:flutter/material.dart';

import '../core/constant.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolbarHeight;
  final Icon? icon;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final double? fontsize;

  const GradientAppBar({
    this.onPressed,
    super.key,
    required this.title,
    this.toolbarHeight = 60.0,
    this.icon,
    this.actions,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(toolbarHeight),
      child: Container(
        height: toolbarHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [a, b, c],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AppBar(
          title: Text(
            overflow: TextOverflow.ellipsis,
            title,
            style: TextStyle(color: Colors.white, fontSize: fontsize),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: icon != null
              ? IconButton(
                  icon: icon!,
                  color: Colors.white,
                  onPressed: onPressed,
                )
              : null,
          actions: actions, // Add this line
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
