import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/responsive/responsive.dart';
import 'package:notes_app/mobile/screens/homepage.dart';
import 'package:notes_app/tablet/screens/homepage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screensize(),
    );
  }
}

class Screensize extends StatefulWidget {
  Screensize({Key? key}) : super(key: key);

  @override
  State<Screensize> createState() => _ScreensizeState();
}

class _ScreensizeState extends State<Screensize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(mobilebody: HomePagem(), desktopbody: HomePaget()));
  }
}
