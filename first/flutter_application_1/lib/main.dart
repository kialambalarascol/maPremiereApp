import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/note.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

/// --- MAIN AVEC INITIALISATION DE FLUTTER_DOWNLOADER ---
Future<void> main() async {
  // Nécessaire avant d'appeler du code asynchrone dans main()
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation du gestionnaire de téléchargement
  await FlutterDownloader.initialize(
    debug: true, // Laisser true pour voir les logs, mettre false en production
    ignoreSsl: true, // utile pour GitHub, sinon certaines URLs https peuvent échouer
  );

  runApp(const MyApp());
}

/// --- APPLICATION PRINCIPALE ---
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Note',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/note': (context) => const Edition(),
      },
    );
  }
}
