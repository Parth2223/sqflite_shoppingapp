import 'package:flutter/material.dart';
import 'package:sqlfliteshop/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primaryColor: appbarColor,
        // appBarTheme: AppBarTheme(color: appbarColor),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        // useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
