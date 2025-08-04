import 'package:flutter/material.dart';
import "../models/task.dart";

class TaskTile extends StatelessWidget {
  Task task;
  Function() onDelete;
  TaskTile({super.key, required this.task, required this.onDelete }); // Required

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name), 
      subtitle: Text(task.description),
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete)
    );
  }
}