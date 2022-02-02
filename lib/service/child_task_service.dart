import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChildTask {
  String _title;
  bool _isDone;
  String _documentId;
  Timestamp _createdAt;
  int _order;

  ChildTask(this._title, this._isDone, this._documentId, this._createdAt, this._order);

  String get title => _title;
  bool get isDone => _isDone;
  String get documentId => _documentId;
  Timestamp get createdAt => _createdAt;
  int get oder => _order;

  ChildTask.fromMap(map) {
    _title = map['title'];
    _isDone = map['isDone'];
    _createdAt = map['createdAt'];
    _order = map['order'];
    _documentId = map.id;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = _title;
    map['isDone'] = _isDone;
    map['createdAt'] = _createdAt;
    map['order'] = _order;
    return map;
  }
}

// 子タスクのServiceクラス
class ChildTaskService extends ChangeNotifier {
  ChildTaskService();

  String uid;
  String documentId;

  List<ChildTask> _taskList = [];

  CollectionReference get dataPath => FirebaseFirestore.instance.collection('users/$uid/todo').doc(documentId).collection('childTasks');
  List get taskList => _taskList;

  void init(List<DocumentSnapshot> documents) {
    _taskList = documents.map((doc) => ChildTask.fromMap(doc)).toList();
  }

  // 子タスクを追加
  void addTask(String title) {
    dataPath.add({'title': title, 'isDone': false, 'createdAt': DateTime.now(), 'order': _taskList.length});
  }

  // 子タスクを削除
  void deleteTask(String documentId) {
    dataPath.doc(documentId).delete();
  }

  // 子タスクのisDone状態を更新
  void switchStateChildTaskData(String childDocumentId, bool isDone) {
    dataPath.doc(childDocumentId).update({'isDone': isDone});
  }

  // 子タスクのorder値を更新
  void updateOrder(String childDocumentId, int order) {
    dataPath.doc(childDocumentId).update({'order': order});
  }

  // タスクのisDone状態を全てクリアする
  void clearStateChildTask() async {
    for (var task in _taskList) {
      switchStateChildTaskData(task.documentId, false);
    }
  }

  // タスクの並び順を変更する
  void sortChildTasks() async {
    for (var i = 0; i < _taskList.length; i++) {
      updateOrder(_taskList[i].documentId, i);
    }
  }
}
