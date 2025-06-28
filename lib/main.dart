import 'package:ecommerce/pages/getSingleProducts.dart';
import 'package:ecommerce/pages/homepage.dart';
import 'package:ecommerce/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetSingleProducts(),
      debugShowCheckedModeBanner: false,
    );
  }
}
