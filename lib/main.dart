import 'package:flutter/material.dart';
import 'package:home/presentation/pages/home.dart';
// import 'package:grocery_app/packages/home/lib/presentation/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
