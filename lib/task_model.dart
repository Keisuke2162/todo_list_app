class ParentTask {
  String title;
  List<Task> taskList;

  ParentTask(this.title, this.taskList);
}

class Task {
  String title;
  bool isDone;

  Task(this.title, this.isDone);
}