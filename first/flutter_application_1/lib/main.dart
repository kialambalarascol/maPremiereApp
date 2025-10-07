import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  //liste 
  List<int> notes=[100,8,9];
  //set pas de doublon, pas ordonné
  Set<String> color={"blue","red","yellow"};
  Map<String, int> pi={
    "john":40,
    "rwan":18
  };
  pi.forEach((key, value) {
    print ("$key : $value");
    },);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'lesson1',
      theme: ThemeData(primarySwatch: Colors.blue),

      home: Scaffold(
        appBar: AppBar(title: Text("Apprentissage",textAlign: TextAlign.center,),
        backgroundColor: Colors.blueAccent,
        leading: Icon(Icons.menu),
        actions: [IconButton(onPressed:(){}, icon: Icon(Icons.favorite))],
        ),

      backgroundColor:Color.fromARGB(255, 38, 255, 208),
      body:GridView.count(
        crossAxisCount: 2,
        children: List.generate(20,(index)){
          return Container(
            margin:EdgeInsets.all(20),
            color: Colors.blue.shade300),
            child: Center(
                child: Text($index+1),
            ),
          ),
        },
      ),
      
      ),
        
          );
  }
}
/*
body:ListView.builder(itemCount: 50,itemBuilder: (context,index){
        return ListTile(

                    leading: Icon(Icons.person,color:Colors.green),
                    title: Text("sujet ${index+1}"),
                    subtitle: Text("Voici une info pour la ${index+1} personne." ),
                    subtitleTextStyle: TextStyle(color: Colors.purple),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: (){

                    },
        );
      },
          ),
*/