import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/lecture_widgets.dart';

class LectureScreen extends StatefulWidget {
  @override
  _LectureScreenState createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ders Ekleme Sayfası"),
      ),
      body: LectureWidgets(),
    );
  }
}
