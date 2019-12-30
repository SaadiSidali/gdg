import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import './task.dart';

class Tasks with ChangeNotifier {
  final auth;
  final String userId;

  Tasks(this.auth, this.userId);

  List<Task> _tasks = [];
  List<Task> get tasks {
    return [..._tasks];
  }

  List<Task> get doneTasks {
    return _tasks.where((task) => task.isDone).toList();
  }

  Task findById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  Future<void> addTask(Task task) async {
    final url = 'https://gdg-app-22cea.firebaseio.com/tasks.json?auth=$auth';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': task.title,
            'description': task.description,
            'userId': userId
          },
        ),
      );

      final newtask = Task(
        json.decode(response.body)['name'],
        task.title,
        task.description,
      );
      _tasks.add(newtask);
      notifyListeners();
    } catch (up) {
      print(up);
      throw up;
      //haha
    }
  }
}
