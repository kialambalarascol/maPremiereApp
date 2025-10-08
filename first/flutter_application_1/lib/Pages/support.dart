import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Support"),),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
             child: Text("page d'accueil ",
             style: TextStyle(color: Colors.purple),
             ),
             ),
        ),
      ),
    );
  }
}