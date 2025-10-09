import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

@override
void initState() {
  super.initState();
  chargement(); 
  String json =jsonEncode(Notes);
}

Future <void> chargement()async{
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    
    String? json = prefs.getString('notes');
    List<dynamic> jsonList = jsonDecode(Json);
List<Map<String, String>> Notes = jsonList.map((e) => Map<String, String>.from(e)).toList();

  });

}
List <Map<String,String>> Notes = [] ;

  TextEditingController titre = TextEditingController(); 
  TextEditingController contenu = TextEditingController();
  void ajout() => setState(() {
  Notes.add({"titre":titre.text,"contenu":contenu.text});
  titre.clear();
  contenu.clear();

  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("My Note", style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Notes.length,
              itemBuilder:(context, index) {
                final note= Notes[index];
                return Card(
                  color: const Color.fromARGB(255, 240, 239, 239),
                  margin: EdgeInsets.all( 15),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListTile(
                      
                      title: Center(
                        child: Text(note["titre"]??"",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple),
                          ),
                      ),
                      onLongPress: () {
                        
                      },
                    ),
                  ),

                  
                );
                
              }, ),
          )
        ],

      ),
      floatingActionButton: FloatingActionButton
      (onPressed: (){
        showDialog(
          context: context, builder: (context){
          return AlertDialog(
            title: TextField(
              controller: titre,
              decoration: InputDecoration(
                hintText:"Titre",
                hintStyle: TextStyle(color: Colors.deepPurple[200]),
                border: OutlineInputBorder(),
              ),
              
            ),
            content: TextField(
              controller: contenu,
              decoration: InputDecoration(
                hintText: "Contenu",
                hintStyle: TextStyle(color: Colors.deepPurple),
                border: OutlineInputBorder()
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
                    onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text("Annulez",style: TextStyle(color: Colors.white),
                  ),
                  ),
              
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: (){
                    if (titre.text.isNotEmpty){
                       ajout();
                  Navigator.pop(context);
                    }
                  else {
                     ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Remplis au moins le titre "),
                          backgroundColor: Colors.red,
                          duration: Duration(
                            seconds: 2
                          ),
                        )
                     );
                        }
                   
                }, 
                child: const Text("Ajouter",style: TextStyle(color: Colors.white),
                ),
                ),
                ],
                ),
            ],
            );
          }
        );
      } ,
      backgroundColor: Colors.white,
      child: Icon(Icons.post_add_rounded,size: 40,color: Colors.deepPurple,
      ),
      ),
    );
  }
}