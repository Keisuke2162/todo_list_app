import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ParentTask {
  String _title;
  String _documentId;
  Timestamp _createdAt;

  ParentTask(this._title, this._documentId, this._createdAt);

  String get title => _title;
  String get documentId => _documentId;
  Timestamp get createdAt => _createdAt;

  ParentTask.fromMap(map) {
    _title = map['title'];
    _createdAt = map['createdAt'];
    _documentId = map.id;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = _title;
    map['createdAt'] = _createdAt;
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
    dataPath.add({'title': title, 'createdAt': DateTime.now()});
  }

  // 親タスクを削除
  void deleteTask(String documentId) {
    dataPath.doc(documentId).delete();
  }
}