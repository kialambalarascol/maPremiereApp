import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/note.dart';
import 'package:flutter_application_1/notification.dart';




void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Notif().initNotif();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Note',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/note': (context) => const Edition(),
      },
    );
  }
}
