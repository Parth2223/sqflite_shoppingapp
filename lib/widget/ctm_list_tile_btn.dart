import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';

class ListTileButton extends StatefulWidget {
  ListTileButton(
      {super.key,
      this.onTap,
      this.leading,
      required this.title,
      this.trailing});

  final void Function()? onTap;
  final Widget? leading;
  final Widget? trailing;

  final String title;

  @override
  State<ListTileButton> createState() => _ListTileButtonState();
}

class _ListTileButtonState extends State<ListTileButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        tileColor: Colors.grey[200],
        onTap: widget.onTap,
        leading: widget.leading,
        title: Text(
          widget.title,
          style: headlineNormal,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
