import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ParentTask {
  String title;
  String documentId;
  // List<Task> taskList;

  ParentTask(this.title, this.documentId);
}

class ChildTask {
  String title;
  bool isDone;

  ChildTask(this.title, this.isDone);
}

class TaskModel extends ChangeNotifier {
  
  final firestoreInstance = FirebaseFirestore.instance;

  List<ParentTask> taskList = [];

  // 表示する子タスク
  List<ChildTask> childTaskList = [];


  // 子タスクの一覧を取得する
  void getChildTaskList(String documentId) {

    firestoreInstance.collection('tasks').doc(documentId).collection('childTasks').get().then((childQuerySnapshot) {

      print("テスト：check2 ${childQuerySnapshot}");

      final List<ChildTask> childTasks = childQuerySnapshot.docs.map((DocumentSnapshot childDocument) {
        Map<String, dynamic> data = childDocument.data() as Map<String, dynamic>;
        final String childTitle = data['title'];


        final bool isDone = data['isDone'];
        return ChildTask(childTitle, isDone);

      }).toList();


      print("テスト：check4 return childTasks ${childTasks}");

      this.childTaskList = childTasks;
      notifyListeners();
      // return childTasks;


      /*
      final List<ChildTask> childTaskList = childQuerySnapshot.docs.map((DocumentSnapshot childDocument) {
        Map<String, dynamic> data = childDocument.data() as Map<String, dynamic>;
        final String childTitle = data['title'];


        final bool isDone = data['isDone'];
        return ChildTask(childTitle, isDone);

      }).toList();
      */



    });
  }

  // データ取得
  void fetchTaskData() {

    firestoreInstance.collection('tasks').snapshots().listen((QuerySnapshot snapshot) {

      final List<ParentTask> taskList = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        final String title = data['title'];
        final String documentId = document.id;

        return ParentTask(title, documentId);


      }).toList();

      this.taskList = taskList;
      notifyListeners();
    });
  }
}

