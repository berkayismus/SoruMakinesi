import 'package:http/http.dart' as http;

class QuestionApi{

  static String base_url = "http://10.0.3.2";

  static Future getQuestions(String lecture_id,String question_limit) async {
    var response = await http.get("$base_url/question/all/?lecture_id=$lecture_id&limit=$question_limit");
    return response;
  }

}