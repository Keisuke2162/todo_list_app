import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ParentTask {
  String _title;
  String _documentId;

  ParentTask(this._title, this._documentId);

  String get title => _title;
  String get documentId => _documentId;

  ParentTask.fromMap(map) {
    _title = map['title'];
    _documentId = map.id;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = _title;
    return map;
  }
}

// 親タスクのServiceクラス
class ParentTaskService extends ChangeNotifier {
  ParentTaskService();

  String uid;
  List<ParentTask> _taskList;

  CollectionReference get dataPath => FirebaseFirestore.instance.collection('users/$uid/todo');
  List get taskList => _taskList;

  void init(List<DocumentSnapshot> documents) {
    _taskList = documents.map((doc) => ParentTask.fromMap(doc)).toList();
  }

  // 親タスクを追加
  void addTask(String title) {
    dataPath.add({'title': title});
  }

  // 親タスクを削除
  void deleteTask(String documentId) {
    dataPath.doc(documentId).delete();
  }
}