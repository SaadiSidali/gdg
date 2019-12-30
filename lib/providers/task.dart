import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  bool isDone;
  Task(this.id, this.title, this.description);


}
