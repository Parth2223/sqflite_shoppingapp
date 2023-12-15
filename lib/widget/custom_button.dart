import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_textstyle.dart';

class customButton extends StatefulWidget {
  customButton({super.key, required this.title, required this.onTap});
 final  String title;
  final void Function()? onTap;
  @override
  State<customButton> createState() => _customButtonState();
}

class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: _buildBoxRadius(),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          widget.title,
          style: buttonTextStyle,
        ),
      ),
    );
  }

  _buildBoxRadius() {
    return BorderRadius.all(Radius.circular(5));
  }
}
