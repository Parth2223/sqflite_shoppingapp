import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class customBadgesCart extends StatefulWidget {
  customBadgesCart({super.key, required this.cartBadgeAmount});
  final int cartBadgeAmount;
  @override
  State<customBadgesCart> createState() => _customBadgesCartState();
}

class _customBadgesCartState extends State<customBadgesCart> {
  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: badges.BadgeAnimation.slide(),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Colors.black,
      ),
      badgeContent: Text(
        widget.cartBadgeAmount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }
}
