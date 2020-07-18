import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/question_widgets.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Makinesi"),
      ),
      body: QuestionWidgets(),
    );
  }
}
