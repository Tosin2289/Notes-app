import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/mobile/screens/note_editor.dart';
import 'package:notes_app/mobile/screens/note_reader.dart';
import 'package:notes_app/style/app_style.dart';
import 'package:notes_app/mobile/widgets/note_card.dart';
import 'package:notes_app/tablet/screens/note_editor.dart';
import 'package:notes_app/tablet/screens/note_reader.dart';
import 'package:notes_app/tablet/widget/note_card.dart';

class HomePaget extends StatefulWidget {
  HomePaget({Key? key}) : super(key: key);

  @override
  State<HomePaget> createState() => _HomePagetState();
}

class _HomePagetState extends State<HomePaget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.mainColor,
        appBar: AppBar(
          backgroundColor: AppStyle.mainColor,
          elevation: 0,
          title: Text(
            "Notes".toUpperCase(),
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your recent Notes",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("notes")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        children: snapshot.data!.docs
                            .map((note) => noteCardT(() {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return NoteReaderScreenT(note);
                                    },
                                  ));
                                }, note))
                            .toList(),
                      );
                    }
                    return Text(
                      "there's no Notes",
                      style: GoogleFonts.nunito(color: Colors.white),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return NoteEditorScreenT();
            })));
          },
          label: Text("Add Notes"),
          icon: Icon(Icons.add),
        ));
  }
}
