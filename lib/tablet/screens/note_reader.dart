import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/style/app_style.dart';

class NoteReaderScreenT extends StatefulWidget {
  NoteReaderScreenT(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreenT> createState() => _NoteReaderScreenTState();
}

class _NoteReaderScreenTState extends State<NoteReaderScreenT> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.cardsColor[color_id],
        iconTheme: IconThemeData(color: Colors.black, size: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              widget.doc["note_content"],
              overflow: TextOverflow.ellipsis,
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
