import 'package:flutter/material.dart';

class customTextFields extends StatefulWidget {
  customTextFields(
      {super.key,
      required this.controller,
      required this.title,
      this.suffixIcon,
      this.validator,
      this.hintText,
      this.maxLength,
      this.onTap,
      this.readOnly = false,
      this.keyboardType,
      this.prefixIcon});
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final String title;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final bool readOnly;
  final int? maxLength;
  final TextInputType? keyboardType;
  // bool? obscureText;
  @override
  State<customTextFields> createState() => _customTextFieldsState();
}

class _customTextFieldsState extends State<customTextFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          TextFormField(
              // obscureText: widget.obscureText,
              onTap: widget.onTap,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              readOnly: widget.readOnly,
              validator: widget.validator,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: widget.suffixIcon,
                  prefixIcon: widget.prefixIcon,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
}
