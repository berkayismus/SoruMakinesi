import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/question_widgets.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {

    final Color iconButtonColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Makinesi"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),onPressed: _questionAddClicked ,color: iconButtonColor,),
          IconButton(icon: Icon(Icons.update),onPressed: _questionUpdateClicked, color: iconButtonColor,)
        ],
      ),
      body: QuestionWidgets(),
    );
  }

  void _questionAddClicked() {
    Navigator.pushNamed(context, "/questionAdd");
  }

  void _questionUpdateClicked() {
    Navigator.pushNamed(context, "/questionUpdate");
  }


}
