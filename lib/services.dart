import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:searchfunc/models/task.dart';

class Services {
  static const String url = "https://abistestherokuapi.herokuapp.com/api/todos";
  static Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Task> list = parseTasks(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Task> parseTasks(String responseBody) {
    final decodedData = jsonDecode(responseBody);
    final allTasks = decodedData["allTodos"];

    final parsed = allTasks.cast<Map<String, dynamic>>();
    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  }
}
