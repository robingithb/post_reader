import 'package:flutter/material.dart';
import 'package:host_reader/myHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "post reader",
      home: MyHomePage(),
    );
  }
}
