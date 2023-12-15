import 'package:flutter/material.dart';

class customAppBar extends StatelessWidget implements PreferredSizeWidget {
  customAppBar(
      {super.key,
      this.title,
      this.icon,
      this.leading,
      this.color,
      this.actions,
      this.onTap,
      this.automaticallyImplyLeading = false});
  final Widget? title;
  final IconData? icon;
  final Color? color;
  final List<Widget>? actions;
  final Widget? leading;
  final void Function()? onTap;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: title,
      actions: actions,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)]),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
