import 'package:flutter/material.dart';
import "../models/task.dart";
import "../components/task_tile.dart";
import "new_task.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController descInputController = TextEditingController();

  List<Task> tasks = [];

  void saveTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void openNewTaskPage() async {
    Task? task = await Navigator.push<Task>(context, MaterialPageRoute(builder: (context) => NewTaskPage(
      nameController: nameInputController, 
      descController: descInputController
    )));

    if(task != null) {
      saveTask(task);
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
            tasks.isNotEmpty 
            ? Expanded(
              child: ListView.builder(
              itemCount: tasks.length, 
              itemBuilder: (context, index) => TaskTile(
                task: tasks[index], 
                onDelete: () { deleteTask(index);  }
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