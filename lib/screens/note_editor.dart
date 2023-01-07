import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController mainController = TextEditingController();
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              scribbleEnabled: true,
              style: AppStyle.mainTitle,
              controller: titleController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Title'),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              scribbleEnabled: true,
              style: AppStyle.mainContent,
              controller: mainController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Text'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: (() async {
          FirebaseFirestore.instance
              .collection('notes')
              .add({
                'note_title': titleController.text,
                'creation_date': date,
                'note_content': mainController.text,
                'color_id': color_id
              })
              .then((value) => {
                    print(value.id),
                    Navigator.pop(context),
                  })
              .catchError((error) =>
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Unable to save due to $error"),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(vertical: 20),
                  )));
        }),
        child: Icon(Icons.save_outlined),
      ),
    );
  }
}
