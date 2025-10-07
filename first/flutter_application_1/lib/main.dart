import 'package:flutter/material.dart';

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
      title: 'lesson1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Apprentissage"),
          backgroundColor: Colors.blueAccent,
          leading: const Icon(Icons.menu),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 38, 255, 208),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => print("container cliqué"),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.blue.shade300,
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Text(
                          "je suis le lutin gronon",
                          style: TextStyle(
                            color: Colors.amber.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
