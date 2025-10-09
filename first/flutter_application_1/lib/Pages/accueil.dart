import 'package:flutter/material.dart';

  
   
class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  void liste(int index) =>setState((){selectedIndex =index;})  ;
  
   

  int selectedIndex = 0;

final pages =[Home() ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accueil"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Icon(Icons.person_2_rounded,size: 100,),
              ),

              ListTile(
                title: Text("accueil"),
                leading: Icon(Icons.home),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text("support"),
                leading: Icon(Icons.support_agent),
                onTap: () => Navigator.pushNamed(context, "/support"),
              ),        
          ],
          ),
      ),
      bottomNavigationBar:BottomNavigationBar
      (items :  [
        BottomNavigationBarItem (icon: Icon(Icons.home),label:"Accueil" ),
        BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: "Support")
      ],currentIndex: selectedIndex ,
      onTap: liste,
      ),
      body: pages[selectedIndex],
    );
   
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController demande = TextEditingController(); 

  String recupNom = "";
  void message() => setState(() {recupNom = "Bonjour ${demande.text}";});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Padding(
          padding:EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 10,
            children:[
              Text("yo dit un truc"),
              TextField(
                controller: demande,
                decoration: InputDecoration(
                  label: Text("vsy Franky"),
                  hintText: " allez mon reuf !",
                  border: OutlineInputBorder(),
                  
                )
                ),
              ElevatedButton(onPressed: () {message();
              } , child: Text("Envoyer")),
              Text(recupNom),
              ],
          ),
        ),
        
      ),
    );
  }
}