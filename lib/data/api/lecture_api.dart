import 'package:http/http.dart' as http;

class LectureApi{

  static String base_url = "http://10.0.3.2";

  static Future getLectures() async {
    var response = await http.get("$base_url/lecture/all");
    return response;
  }

  static Future lectureAdd(String lecture_name,String lecture_code) async {
    Map data = {
      "lecture_name":lecture_name,
      "lecture_code":lecture_code,
    };
    var response = await http.post("$base_url/lecture/add/index.php",body: data);
    if(response.statusCode == 200) {
      return response;
    } else{
      throw("Ders Eklerken hata");
    }
  }

}