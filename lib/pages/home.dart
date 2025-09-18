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
      await TasksDBHandler.addTask(task);
      setState(() { });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo app"), backgroundColor: Colors.green[300],),
      backgroundColor: Colors.green[100],
      body: Center(
        child: StreamBuilder(
          stream: TasksDBHandler.getTasksStream(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading tasks...")
              );
            } 
            else if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("There are currently no tasks to display.")
              );
            } 
            else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => TaskTile(
                  task: Task( // GETTING THE DATA READ FROM THE DOCUMENT
                    name: snapshot.data!.docs[index]["name"], 
                    description: snapshot.data!.docs[index]["description"]
                  ),
                  onDelete: () { 
                    setState(() {
                      TasksDBHandler.removeTask(snapshot.data!.docs[index].id);
                    });
                  }
                )
              );
            }
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        child: Icon(Icons.add, color: Colors.black), 
        onPressed: openNewTaskPage
      )
    );
  }
}