import 'package:http/http.dart' as http;

class LectureApi{

  static String base_url = "http://10.0.3.2";

  static Future getLectures() async {
    var response = await http.get("$base_url/lecture/all");
    return response;
  }

}