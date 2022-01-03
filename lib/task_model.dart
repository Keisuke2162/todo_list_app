import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ParentTask {
  String title;
  String documentId;

  ParentTask(this.title, this.documentId);
}

class ChildTask {
  String title;
  bool isDone;
  String documentId;

  ChildTask(this.title, this.isDone, this.documentId);
}

class TaskModel extends ChangeNotifier {
  
  final firestoreInstance = FirebaseFirestore.instance;

  // 表示する親タスク
  List<ParentTask> taskList = [];

  // 表示する子タスク
  List<ChildTask> childTaskList = [];

  // 親タスク一覧を取得
  void fetchParentTaskData() {

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

  // 子タスクの一覧を取得する
  void fetchChildTaskData(String documentId) {

    firestoreInstance.collection('tasks').doc(documentId).collection('childTasks').snapshots().listen((QuerySnapshot snapshot) {
      final List<ChildTask> childTasks = snapshot.docs.map((DocumentSnapshot document) {

        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String childTitle = data['title'];
        final bool isDone = data['isDone'];
        final documentId = document.id;

        return ChildTask(childTitle, isDone, documentId);
      }).toList();

      this.childTaskList = childTasks;
      notifyListeners();

    });
  }

  // 親タスクのデータを追加
  void addParentTaskData(String title) {
    // FirebaseFirestore.instance.collection('hunters').doc('senritsu').update({'post': 'ノストラードファミリー'});

    firestoreInstance.collection('tasks').add({'title': title});
  }
  
  // 子タスクのデータを追加
  void addChildTaskData(String title, String documentId) {
    firestoreInstance.collection('tasks').doc(documentId).collection('childTasks').add({'title': title, 'isDone': false});
  }
  
  // 子タスクのisDone状態を更新
  void switchStateChildTaskData(String parentDocumentId, String childDocumentId, bool isDone) {
    firestoreInstance.collection('tasks').doc(parentDocumentId).collection('childTasks').doc(childDocumentId).update({'isDone': isDone});
  }


}

