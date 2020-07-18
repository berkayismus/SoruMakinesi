import 'dart:convert';

import "package:flutter/material.dart";
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/models/lecture.dart';

class QuestionWidgets extends StatefulWidget {
  @override
  _QuestionWidgetsState createState() => _QuestionWidgetsState();
}

class _QuestionWidgetsState extends State<QuestionWidgets> {

  // web servisten dersleri çekelim
  List<Lecture> _lectures = List<Lecture>();
  List<DropdownMenuItem<Lecture>> _lectureItems = List<DropdownMenuItem<Lecture>>();
  Lecture _selectedLecture;

  // TextField'ların controller kısımları tanımlanıyor
  TextEditingController _questionQuantityController;
  TextEditingController _getQuestionsController;
  bool _getQuestionsState = false;

  @override
  void initState() {

    getLecturesFromApi();
    _selectedLecture = _lectureItems[0].value;

    _questionQuantityController = TextEditingController();
    _getQuestionsController = TextEditingController();
    super.initState();

  }

  @override
  void dispose() {

    _questionQuantityController.dispose();
    _getQuestionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 5),
      child: Column(
        children: <Widget>[
          // birinci satır
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  "Hangi Ders",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                margin: EdgeInsets.only(top: 10, left: 20),
              ),
              Container(
                child: ddMenu(),
                margin: EdgeInsets.only(top: 10, left: 20),
              )
            ],
          ),

          // ikinci satır
          Row(
            children: <Widget>[
              Container(
                width: 100,
                height: 50,
                margin: EdgeInsets.only(top: 10, left: 140),
                child: TextField(
                  controller: _questionQuantityController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kaç Soru',
                  ),
                ),
              ),
            ],
          ),

          // üçüncü satır
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 140),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      debugPrint(_questionQuantityController.text);
                      _getQuestionsState = true;
                    });
                  },
                  child: Text("Soru Getir"),
                  color: Colors.orange,
                ),
              ),
            ],
          ),

          // dördüncü satır
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: _getQuestionsController,
                    enabled: _getQuestionsState,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Getirilen Sorular',
                    ),
                    maxLines: 5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ddMenu() {
    return DropdownButton(
      onChanged: (Lecture value) => onChangedItem(value),
      value: _selectedLecture,
      items: _lectureItems,
    );
  }

  void getLecturesFromApi() {
    setState(() {
      LectureApi.getLectures().then((response) {
        Iterable list = jsonDecode(response.body);
        this._lectures = list.map((lecture) => Lecture.fromJson(lecture)).toList();
        //debugPrint(_lectures[0].lecture_name + " " + _lectures[0].lecture_code); // çalışıyor
        addLectureItems(_lectures);
      });
    });
  }

  void addLectureItems(List<Lecture> lectures) {
    for(Lecture lecture in lectures){
      _lectureItems.add(getLectureItem(lecture));
    }
  }

  DropdownMenuItem<Lecture> getLectureItem(Lecture lecture) {
    return DropdownMenuItem(
      child: Text(lecture.lecture_name),
      value: lecture,
    );
  }

  onChangedItem(Lecture value) {
    _selectedLecture = value;
  }



  





} // State class sonu
