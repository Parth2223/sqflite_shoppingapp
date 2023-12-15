import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';

class customTextFormField extends StatefulWidget {
  customTextFormField(
      {super.key,
      required this.controller,
      this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      required this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.fillColor,
      this.maxLength,
      this.contentPadding,
      this.label,
      this.onTap,
      this.filled,
      this.readOnly = false,
      required this.keyboardType});

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? label;
  final bool? filled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  @override
  State<customTextFormField> createState() => _customTextFormFieldState();
}

class _customTextFormFieldState extends State<customTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      enabled: true,
      textInputAction: TextInputAction.next,
      keyboardType: widget.keyboardType,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
          contentPadding: widget.contentPadding,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: blackColor, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          hintText: widget.hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.normal),
          label: widget.label,
          fillColor: widget.fillColor,
          filled: widget.filled,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon),
    );
  }
}
