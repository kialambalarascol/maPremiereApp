import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/support.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accueil"),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFF9F9F9),
        child: ListView(
          children: const [
            DrawerHeader(
              child: ListTile(
                title: Text("Menu"),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Support()),
            );
          },
          child: const Text(
            "Page de Support",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ),

      /// ✅ Le bouton flottant violet
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action du bouton
        },
        backgroundColor: Color(0xFFF9F9F9), // Violet
        child: const Icon(
          Icons.add_rounded,
          color: Colors.purple, // Icône blanche
          size: 32,
        ),
      ),
    );
  }
}
