import 'package:flutter/material.dart';
import 'package:secucalls/constant/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String title;

  const CustomAppBar({
    super.key,
    required this.icon,
    required this.title, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ), // Set the leading icon
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: textBlack21Italic,
      ),
      // Set the title text
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
