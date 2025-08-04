import 'package:flutter/material.dart';
import "../models/task.dart";

class NewTaskPage extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descController;
  // VoidCallback onSaveBtnClicked; // "VoidCallback" = What you want to use to define a method that does not return any value or take any arguments
  
  NewTaskPage({super.key, required this.nameController, required this.descController});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  bool hasErrors = false;
  String errorMsg = "";

  void checkErrors() {
    setState(() {
      if(widget.nameController.text == "") {
        errorMsg = "Name of the task must not be empty!";
        hasErrors = true;
      } else {
        hasErrors = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New task"), backgroundColor: Colors.green[300]),
      backgroundColor: Colors.green[100],
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: widget.nameController,
                decoration: InputDecoration(floatingLabelStyle: TextStyle(color: Colors.green[700]),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900)),
                  label: Text("Task name:")
                )
              ),
              TextField(
                controller: widget.descController,
                decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: Colors.green[700]),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900)),
                  label: Text("Task description:")
                )
              ),
              Text(errorMsg)
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        child: Icon(Icons.save, color: Colors.black),
        onPressed: () {
          checkErrors();

          if(!hasErrors) {
            Task task = Task(name: widget.nameController.text, description: widget.descController.text);
            widget.nameController.clear();
            widget.descController.clear();
            Navigator.pop(context, task);
          }
        }
      )
    );
  }
}