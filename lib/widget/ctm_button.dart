// import 'package:flutter/material.dart';
// import 'package:sqlfliteshop/comman/all_colors.dart';
//
// class customButton extends StatefulWidget {
//   customButton({super.key, required this.onTap, required this.title});
//   void Function()? onTap;
//   String? title;
//   @override
//   State<customButton> createState() => _customButtonState();
// }
//
// class _customButtonState extends State<customButton> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: widget.onTap,
//         child: Container(
//           height: 45,
//           width: 300,
//           decoration: BoxDecoration(
//               color: brown800,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(color: brown800, blurRadius: 5, offset: Offset(2, 2))
//               ]),
//           child: Center(
//             child: Text(
//               widget.title!,
//               style: TextStyle(
//                   color: white,
//                   fontSize: 25,
//                   fontWeight: FontWeight.normal,
//                   letterSpacing: 1),
//             ),
//           ),
//         ));
//   }
// }
