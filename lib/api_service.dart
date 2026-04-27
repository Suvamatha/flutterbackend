import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';
  // static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<List<dynamic>> getTasks() async{
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if(response.statusCode == 200){
      return jsonDecode(response.body);

    }else{
      throw Exception("Failed to load Task");
    }
  }
  static Future<void> createTask(String title) async{
    await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {"Content-Type":"application/JSON"},
      body: jsonEncode({"title":title}),
    );
  }
  static Future<void>deleteTask(int id)async{
    await http.delete(Uri.parse('$baseUrl/tasks/$id'));
  }
  static Future<void>toggleTask(int id)async{
    await http.patch(Uri.parse('$baseUrl/tasks/$id'));
  }
}