import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/models/lecture.dart';

class QuestionUpdateWidgets extends StatefulWidget {
  @override
  _QuestionUpdateWidgetsState createState() => _QuestionUpdateWidgetsState();
}

/*
*       "lecture_id":lecture.lecture_id,
      "question_id":oldQuestion.question_id,
      "question_question":newQuestion,
      "question_answers":newAnswers,
      "question_validate_answer":newValidateAnswer,
*
*
* */

class _QuestionUpdateWidgetsState extends State<QuestionUpdateWidgets> {

  //ddMenu
  List<Lecture> _lectures = List<Lecture>();
  List<DropdownMenuItem<Lecture>> _lectureItems = List<DropdownMenuItem<Lecture>>();
  Lecture _selectedLecture;

  // consts
  final double sizedBoxHeightSpace = 20.0;
  final double sizedBoxWithSpace = 20.0;

  @override
  void initState() {
    super.initState();
    getLecturesFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildFirstRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),

        ],
      ),
    );
  }

  buildFirstRowWidget() {
    return Row(
      children: <Widget>[
    Container(
      width: 100,
    child: Text("Hangi Ders",style: customTextStyle(),),
    ),
        SizedBox(width: sizedBoxWithSpace,),

        DropdownButton(
          value: _selectedLecture,
          items: _lectureItems,
          onChanged: (Lecture selected)=> onChangedLecture(selected),
        ),
      ],
    );
  }

  void getLecturesFromApi() {
    LectureApi.getLectures().then((response) {
      setState(() {
        Iterable lectureList = jsonDecode(response.body);
        this._lectures = lectureList.map((lecture) => Lecture.fromJson(lecture)).toList();
        _selectedLecture = _lectures[0];
        getLectureWidgets();
      });
    });
  }

  List<DropdownMenuItem<Lecture>> getLectureWidgets() {
    for(Lecture lecture in _lectures){
      _lectureItems.add(getLectureWidget(lecture));
    }
  }

  DropdownMenuItem<Lecture> getLectureWidget(Lecture lecture) {
    return DropdownMenuItem(
      child: Text(lecture.lecture_name),
      value: lecture,
    );
  }

  onChangedLecture(Lecture selected) {
    setState(() {
      _selectedLecture = selected;
    });
  }



  customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }
}
