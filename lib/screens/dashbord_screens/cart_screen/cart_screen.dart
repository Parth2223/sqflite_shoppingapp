import 'package:flutter/material.dart';
import 'package:sqlfliteshop/widget/ctm_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        actions: [
          // customBadgesCart();
        ],
      ),
    );
  }
}
