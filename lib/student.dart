import 'dart:convert';
import 'package:http/http.dart' as http;

class Student{
  String baseUrl = "http://10.0.2.2:8000/my_app/student/";
  Future<List> getAllStudent() async{
    try {
      var responese = await http.get(Uri.parse(baseUrl));
      if (responese.statusCode == 200) {
        return json.decode(responese.body);
      } else {
        return Future.error("Server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}