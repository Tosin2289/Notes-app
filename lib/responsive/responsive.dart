import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobilebody;
  final Widget desktopbody;
  Responsive({required this.mobilebody, required this.desktopbody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobilebody;
      } else {
        return desktopbody;
      }
    });
  }
}
