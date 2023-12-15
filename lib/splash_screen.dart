import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlfliteshop/screens/Authenitcation_screen/login_screen.dart';
import 'package:sqlfliteshop/screens/dashbord_screens/bottom_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getUserLoginOrNot();
    super.initState();
  }

  Future<void> getUserLoginOrNot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var Id = prefs.getInt('userId');

    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      if (Id != null) {
        return BottomScreen();
      } else {
        return LoginPage();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset("assets/images/logo/hello.json")),
    );
  }
}
