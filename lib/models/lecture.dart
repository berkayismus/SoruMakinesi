class Lecture{
  String lecture_id;
  String lecture_name;
  String lecture_code;

  // constructor
  Lecture(this.lecture_name,this.lecture_code);
  Lecture.withEmpty();
  Lecture.withId(this.lecture_id,this.lecture_name,this.lecture_code);
  Lecture.fromJson(Map json){
    lecture_id = json["lecture_id"].toString();
    lecture_name = json["lecture_name"];
    lecture_code = json["lecture_code"];
  }

  static List<Lecture> getLectures() {
    return <Lecture>[
      Lecture("Yapay Öğrenme", '1'),
      Lecture("Bilgisayar Programcılığı", '2'),
      Lecture("Veri Madenciliği", '3'),
      Lecture("Matematik", '4'),
      Lecture("Fizik", '5'),
    ];
  }


}



