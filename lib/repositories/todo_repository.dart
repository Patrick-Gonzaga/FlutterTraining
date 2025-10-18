import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/task_model.dart';

final jsonKey = 'taskList';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<TaskModel>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(jsonKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => TaskModel.fromJson(e)).toList();
  }

  void saveTaskList(List<TaskModel> taskList){
    final String jsonTaskList = json.encode(taskList);
    sharedPreferences.setString(jsonKey, jsonTaskList);
    print(jsonTaskList);
  }
}
