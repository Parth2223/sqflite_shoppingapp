import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';

class customAddressTextField extends StatefulWidget {
  customAddressTextField(
      {super.key, required this.controller, this.onTap, this.suffixIcon});
  final TextEditingController? controller;
  final void Function()? onTap;
  final Widget? suffixIcon;
  @override
  State<customAddressTextField> createState() => _customAddressTextFieldState();
}

class _customAddressTextFieldState extends State<customAddressTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
          onTap: widget.onTap,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: blackColor, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            // contentPadding: EdgeInsets.symmetric(vertical: 15),
          )),
    );
  }
}
