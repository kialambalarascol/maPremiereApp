import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  // Liste 
  List<int> notes = [100, 8, 9];

  // Set : pas de doublon, pas ordonné
  Set<String> color = {"blue", "red", "yellow"};

  // Map
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
      title: 'lesson1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Apprentissage", textAlign: TextAlign.center),
          backgroundColor: Colors.blueAccent,
          leading: const Icon(Icons.menu),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))],
        ),
        backgroundColor: const Color.fromARGB(255, 38, 255, 208),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(20, (index) {
            return Container(
              margin: const EdgeInsets.all(20),
              color: Colors.blue.shade300,
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
