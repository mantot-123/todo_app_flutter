import "models/task.dart";

class TasksDBHandler {
  static List<Task> tasks = [];

  static void addTask(Task task) {
    tasks.add(task);
  }

  static void removeTask(int index) {
    tasks.removeAt(index);
  }
}