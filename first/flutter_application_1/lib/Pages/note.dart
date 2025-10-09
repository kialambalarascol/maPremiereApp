import 'package:flutter/material.dart';

class Edition extends StatelessWidget {
  const Edition({super.key});

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(note?["titre"] ?? "Sans titre"),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          note?["contenu"] ?? "Aucun contenu.",
          style: const TextStyle(fontSize: 18,color: Colors.deepPurple),
        ),
      ),
    );
  }
}
