import 'package:flutter/material.dart';
import 'package:sqlfliteshop/comman/all_colors.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/cart_screen/cart_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/category_screen/category_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/favorite_screen/favorite_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/home_screen/home_page.dart';

import 'setting_screen/setting_screen.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int selectedindex = 0;
  static List<Widget> widgetscreen = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    CategoryScreen(),
    CartScreen(),
    SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetscreen.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: white), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, color: white),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets_outlined, color: white),
              label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, color: white),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, color: white),
              label: "Setting")
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: bottombarColor,
        unselectedItemColor: blackColor,
        unselectedLabelStyle: TextStyle(
            color: blackColor, fontWeight: FontWeight.bold, fontSize: 15),
        selectedItemColor: white,
        selectedLabelStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        currentIndex: selectedindex,
        onTap: (int index) {
          setState(() {
            selectedindex = index;
          });
        },
      ),
    );
  }
}
