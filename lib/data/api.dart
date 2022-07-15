import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:test_task_flutter/data/task.dart';

Future<List<Task>> fetchTasks() async {
  final response = await http.get(Uri.parse("https://gorest.co.in/public/v2/todos"));
  if (response.statusCode == 200) {
    var tasks = jsonDecode(response.body);
    List<Task> listOfTasks = [];
    for (var task in tasks) {
      listOfTasks.add(Task.fromJson(task));
    }
    return listOfTasks;
  } else {
    throw Exception("Failed to load tasks");
  }
}

final dataProvider = FutureProvider((ref) async {
  TasksData tasksData = TasksData(await fetchTasks());
  return tasksData;
});

class TasksData {
  List<Task> tasks;

  TasksData(this.tasks);

  void addTask(Task task) {
    tasks.add(task);
  }
}