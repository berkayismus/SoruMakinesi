import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/data/api/question_api.dart';
import 'package:soru_makinesi/models/lecture.dart';
import 'package:soru_makinesi/models/question.dart';

class QuestionWidgets extends StatefulWidget {
  @override
  _QuestionWidgetsState createState() => _QuestionWidgetsState();
}

class _QuestionWidgetsState extends State<QuestionWidgets> {

  // Flatbuttons
  List<Lecture> _lectures = List<Lecture>();
  List<Widget> _flatButtons = List<Widget>();
  Lecture _selectedLecture;

  // consts
  final double sizedBoxSpaceWith = 10;
  final Color flatButtonTextColor = Colors.white;
  final Color flatButtonColor = Colors.pink;

  // Controllers
  TextEditingController _questionQuantityController;

  // Question lists
  List<Question> _questions = List<Question>();



  @override
  void initState() {

    super.initState();
    _questionQuantityController = TextEditingController();
    getLecturesFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: buildMainColumnWidget(),
    );
  }

  buildMainColumnWidget() {
    return Column(
      children: <Widget>[
        buildFirstRowWidget(),
        buildSecondRowWidget(),
        buildThirthRowWidget(),
      ],
    );
  }

  buildFirstRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(width: 100,child: Text("Ders:",style: customTextStyle()),),
          SizedBox(width: sizedBoxSpaceWith,),

          Expanded(child :SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: _flatButtons,),),),
        ],
      ),
    );
  }

  buildSecondRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 50,
            child:
            Text("Soru Sayısı",style: customTextStyle(),),
          ),
          SizedBox(width: sizedBoxSpaceWith,),
          Container(
            width: 100,
            height: 50,
            child:
            TextField(
              controller: _questionQuantityController,
              decoration: InputDecoration(
                  labelText: "Soru Adeti",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // butonlar



        ],
      ),
    );
  }



  buildThirthRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 100,
            child: Text("Getir",style: customTextStyle(),),
          ),
          SizedBox(width: sizedBoxSpaceWith,),
          Container(
            height: 50,
            width: 100,
            child: FlatButton(
              child: Text("SIRALI"),
              onPressed: _getOrdinal,
              color: flatButtonColor,
              textColor: flatButtonTextColor,
            ),
          ),
          SizedBox(width: sizedBoxSpaceWith,),

          Container(
            height: 50,
            width: 100,
            child: FlatButton(
              child: Text("RASTGELE"),
              onPressed: getQuestionRandom,
              color: flatButtonColor,
              textColor: flatButtonTextColor,
            ),
          ),


        ],
      ),
    );
  }





  void _getQuestion() {
   // debugPrint("sıralı getire basıldı");
    if(_selectedLecture!=null && _questionQuantityController.text!=""){
      // question getiren fonksiyon yazılacak
      QuestionApi.getQuestions(_selectedLecture.lecture_id, _questionQuantityController.text)
          .then((response) {
            setState(() {
              Iterable questionList = jsonDecode(response.body);
              this._questions = questionList.map((question) => Question.fromJson(question)).toList();
              _questionDialog();
            });
      });
    }
  }

  void getQuestionRandom() {
    debugPrint("rastgele getire basıldı");
  }


  void sendWithEmail() {
    debugPrint("eposta ile göndere basıldı");

  }

  customTextStyle() {
    return TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      color: Colors.red,
    );
  }

  void getLecturesFromApi() {
    LectureApi.getLectures().then((response)  {
      setState(() {
        Iterable list = jsonDecode(response.body);
        this._lectures = list.map((lecture) => Lecture.fromJson(lecture)).toList();
        _selectedLecture = _lectures[0];
        getLectureWidgets();
      });
    });
  }

  List<Widget> getLectureWidgets() {
    for(Lecture lecture in _lectures){
      _flatButtons.add(getLectureWidget(lecture));
    }
  }

  Widget getLectureWidget(Lecture lecture) {
    return FlatButton(
      child: Text(lecture.lecture_name),
      color: Colors.teal,
      textColor: flatButtonTextColor,
      onPressed: (){lectureFlatButtonClicked(lecture);},
    );
  }

  lectureFlatButtonClicked(Lecture lecture) {

   _selectedLecture = lecture;
   debugPrint(_selectedLecture.lecture_name);

  }

  Future<void> _questionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sorular Getirildi'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListBody(
              children: <Widget>[
                Text('Örnek soru 1 : ${_questions[0].question_question}'),
                Text('Örnek cevap 1 : ${_questions[0].question_validate_answer}'),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  

  void _getOrdinal() {
    _getQuestion();
  }
}// class sonu
