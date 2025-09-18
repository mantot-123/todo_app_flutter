import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "firebase_options.dart";
import "models/task.dart";

class TasksDBHandler {
  static CollectionReference tasksCollection = FirebaseFirestore.instance.collection("tasks");
  // static List<Task> tasks = [];

  // CREATE
  static Future<void> addTask(Task task) async {
    final data = await tasksCollection.add({
      "name": task.name,
      "description": task.description
    }); // DocumentReference - reference to the data that was just created
  }

  // READ
  static Stream<QuerySnapshot> getTasksStream() { // QuerySnapshot - contains results (DocumentSnapshots) of the query
    final tasksStream = tasksCollection.snapshots();
    return tasksStream;
  }

  // UPDATE/EDIT
  static Future<void> editTask(String id, String newName, String newDesc) async {
    tasksCollection.doc(id).set({
      "name": newName,
      "description": newDesc
    });
  }

  // DELETE
  static Future<void> removeTask(String id) async {
    tasksCollection.doc(id).delete();
  }

  // static Future<void> updateTasksList() async {
  //   if(tasks.isNotEmpty) {
  //     tasks = [];
  //   }

  //   final queryResults = await FirebaseFirestore
  //     .instance
  //     .collection("tasks")
  //     .get();
    
  //   for(var q in queryResults.docs) {
  //     final taskName = q.data()["name"];
  //     final taskDescription = q.data()["description"];
  //     Task task = Task(
  //       name: taskName, 
  //       description: taskDescription
  //     );
  //     tasks.add(task);
  //   }
  // }
}