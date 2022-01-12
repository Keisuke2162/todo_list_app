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

class ChildTask {
  String _title;
  bool _isDone;
  String _documentId;

  ChildTask(this._title, this._isDone, this._documentId);

  String get title => _title;
  bool get isDone => _isDone;
  String get documentId => _documentId;

  ChildTask.fromMap(map) {
    _title = map['title'];
    _isDone = map['isDone'];
    _documentId = map.id;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = _title;
    map['isDone'] = _isDone;
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

// 子タスクのServiceクラス
class ChildTaskService extends ChangeNotifier {
  ChildTaskService();

  String uid;
  String documentId;

  List<ChildTask> _taskList;

  CollectionReference get dataPath => FirebaseFirestore.instance.collection('users/$uid/todo').doc(documentId).collection('childTasks');
  List get taskList => _taskList;

  void init(List<DocumentSnapshot> documents) {
    _taskList = documents.map((doc) => ChildTask.fromMap(doc)).toList();
  }

  // 子タスクを追加
  void addTask(String title) {
    dataPath.add({'title': title, 'isDone': false});
  }

  // 子タスクを削除
  void deleteTask(String documentId) {
    dataPath.doc(documentId).delete();
  }

  // 子タスクのisDone状態を更新
  void switchStateChildTaskData(String childDocumentId, bool isDone) {

    dataPath.doc(childDocumentId).update({'isDone': isDone});
  }
}
