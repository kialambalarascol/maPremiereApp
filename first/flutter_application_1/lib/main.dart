import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';

void main() {
  runApp(const MyApp());

  // liste 
  List<int> notes = [100, 8, 9];
  // set pas de doublon, pas ordonné
  Set<String> color = {"blue", "red", "yellow"};
  Map<String, int> pi = {
    "john": 40,
    "rwan": 18,
  };

  pi.forEach((key, value) {
    print("$key : $value");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'My Note',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
