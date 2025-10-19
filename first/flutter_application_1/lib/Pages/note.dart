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

  Map<String, String>? note;

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

  void newsave() {
    note?["titre"] = _titleController.text;
    note?["contenu"] = _contentController.text;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool sortie, Object? result) async {
        newsave();
        Navigator.pop(context, note);
        
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: GestureDetector(
            //Ajout pour rendre le titre cliquable même s'il est vide
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                _editingTitle = true;
              });
            },
            child: _editingTitle
                ? TextField(
                    controller: _titleController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    onSubmitted: (value) {
                      setState(() {
                        _editingTitle = false;
                        newsave();
                      });
                    },
                  )
                : Text(
                    _titleController.text.isEmpty
                        ? "Appuyez pour ajouter un titre" //Texte d’aide si vide
                        : _titleController.text,
                    style: const TextStyle(color: Colors.white),
                  ),
          ),
        ),
        backgroundColor: Colors.deepPurple[50],
        body: GestureDetector(
          // Permet de détecter les taps même si le contenu est vide
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              _editingContent = true;
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
                    setState(() {
                      _editingContent = false;
                    });
                  },
                )
              : Container(
                  //Ajout d’une zone cliquable visible même si vide
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(16),
                  constraints: const BoxConstraints(minHeight: 200),
                  child: Text(
                    _contentController.text.isEmpty
                        ? "Appuyez ici pour ajouter du contenu..." //Texte d’aide
                        : _contentController.text,
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                ),
        ),
      ),
    );
  }
}
