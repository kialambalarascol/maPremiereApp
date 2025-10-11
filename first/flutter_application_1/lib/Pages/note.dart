import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';

class Edition extends StatefulWidget {
  const Edition({super.key});

  @override
  State<Edition> createState() => _EditionState();
}

    
class _EditionState extends State<Edition> {

  Object getter = Home();
  bool _editingTitle = false;
    bool _editingContent = false;

    late TextEditingController _titleController;
    late TextEditingController _contentController;

    Map <String,String>? note;

    @override
    void initState() {
      super.initState();
      _titleController = TextEditingController();
      _contentController = TextEditingController();
    }

  @override 
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    note ??= ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    _titleController.text = note?["titre"] ?? "";
    _contentController.text = note?["contenu"] ?? "";
    
  }
  void newsave(){
    note?["titre"] = _titleController.text;
    note?["contenu"] = _contentController.text;
  }

  @override
  Widget build(BuildContext context) {
  

   

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool sortie , Object? result) async {
        newsave();
        sortie=true;
      } ,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              setState(() {
                _editingTitle = true;
              });
            },
            child: _editingTitle
                ? TextField(
                    controller: _titleController,
                    autofocus: true,
                    onSubmitted: (value) {
                      setState(() {
                        _editingTitle = false;
                        newsave();
                      });
                    },
                  )
                : Text(_titleController.text),
                
          ),
      
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[50],
        body: GestureDetector(
          onTap: (){
            setState(() {
              _editingContent=true;
            });
          },
          child: _editingContent 
            ? TextField(
              controller: _contentController,
              autofocus: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onSubmitted: (value) {
                _editingContent=false;
              },
            )
            :Text(_contentController.text, style: TextStyle(color: Colors.deepPurple),)
            
        ),
      ),
    );
  }
}
