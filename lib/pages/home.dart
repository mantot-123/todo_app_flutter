import 'package:flutter/material.dart';
import "../models/task.dart";
import "../components/task_tile.dart";
import "../db.dart";
import "new_task.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController descInputController = TextEditingController();

  void openNewTaskPage() async {
    Task? task = await Navigator.push<Task>(context, MaterialPageRoute(builder: (context) => NewTaskPage(
      nameController: nameInputController, 
      descController: descInputController
    )));

    if(task != null) {
      setState(() {
        TasksDBHandler.addTask(task);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo app"), backgroundColor: Colors.green[300],),
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TasksDBHandler.tasks.isNotEmpty 
            ? Expanded(
              child: ListView.builder(
              itemCount: TasksDBHandler.tasks.length, 
              itemBuilder: (context, index) => TaskTile(
                task: TasksDBHandler.tasks[index], 
                onDelete: () { 
                  setState(() {
                    TasksDBHandler.removeTask(index);
                  });
                }
              )
              ))
            : Text("There are currently no tasks to display.")
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        child: Icon(Icons.add, color: Colors.black), 
        onPressed: openNewTaskPage
      )
    );
  }
}