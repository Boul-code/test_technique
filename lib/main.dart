import 'package:flutter/material.dart';
import 'package:test_technique/pages/home/home.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test technique',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
