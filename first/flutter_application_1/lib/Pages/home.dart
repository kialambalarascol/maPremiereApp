import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: non_constant_identifier_names
  List<Map<String, String>> Notes = [];

  TextEditingController titre = TextEditingController();
  TextEditingController contenu = TextEditingController();

  @override
  void initState() {
    super.initState();
    chargement();
  }

  /// --- CHARGEMENT DES NOTES DEPUIS SHARED_PREFERENCES ---
  Future<void> chargement() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('notes');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      setState(() {
        Notes = jsonList.map((e) => Map<String, String>.from(e)).toList();
      });
    }
  }

  /// --- SAUVEGARDE DES NOTES ---
  Future<void> sauvegarde() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(Notes);
    await prefs.setString('notes', jsonString);
  }

  void ajout() {
    setState(() {
      Notes.add({
        "titre": titre.text,
        "contenu": contenu.text,
      });
      titre.clear();
      contenu.clear();
    });
    sauvegarde();
  }

  void suppression(int index) {
    setState(() {
      Notes.removeAt(index);
    });
    sauvegarde();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "My Note",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Notes.length,
              itemBuilder: (context, index) {
                final note = Notes[index];
                return Card(
                  color: const Color.fromARGB(255, 240, 239, 239),
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        note["titre"] ?? "" ,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/note',
                        arguments: note,
                      );
                    },
                    onLongPress: () {
                      suppression(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: TextField(
                  controller: titre,
                  decoration: InputDecoration(
                    hintText: "Titre",
                    hintStyle: TextStyle(color: Colors.deepPurple[200]),
                    border: const OutlineInputBorder(),
                  ),
                ),
                content: TextField(
                  controller: contenu,
                  decoration: const InputDecoration(
                    hintText: "Contenu",
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Annulez",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {
                          if (titre.text.isNotEmpty) {
                            ajout();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Remplis au moins le titre 😅"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Ajouter",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.post_add_rounded,
          size: 40,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
