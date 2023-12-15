import 'package:flutter/material.dart';

class customIcon extends StatelessWidget {
  customIcon({super.key, required this.icon, this.color, required this.onTap});
  final void Function()? onTap;
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
