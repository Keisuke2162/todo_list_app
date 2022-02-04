import 'package:admob_flutter/admob_flutter.dart';
import 'package:check_list_app/service/child_task_service.dart';
import 'package:check_list_app/service/admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChildDbProcess extends StatelessWidget {

  String uid;
  String documentId;
  String title;

  ChildDbProcess(this.uid, this.documentId, this.title);

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<ChildTaskService>(context);

    taskService.uid = uid;
    taskService.documentId = documentId;

    return StreamBuilder<QuerySnapshot>(

      stream: taskService.dataPath.orderBy('order').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return ChildTaskView("", "");

          default:

            taskService.init(snapshot.data.docs);
            return ChildTaskView(documentId, title);
        }
      },
    );
  }
}

// ignore: must_be_immutable
class ChildTaskView extends StatefulWidget {

  String documentId;
  String parentTaskTitle;

  ChildTaskView(this.documentId, this.parentTaskTitle);

  @override
  _ChildTaskView createState() => _ChildTaskView();
}

class _ChildTaskView extends State<ChildTaskView> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final taskService = Provider.of<ChildTaskService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parentTaskTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_awesome),
            onPressed: () {
              taskService.clearStateChildTask();
            },
          )
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8.0,),
            Flexible(
              // ドラッグ&ドロップできるListView
              child: ReorderableListView.builder(
                // itemExtent: 72,

                // ドラッグ&ドロップを行った後に実行される（onRecorder）
                onReorder: (oldIndex, newIndex) {
                  // 並べ替え処理
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var task = taskService.taskList.removeAt(oldIndex);
                  taskService.taskList.insert(newIndex, task);
                  // 並べ替え後のorderをfirestoreに保存
                  taskService.sortChildTasks();
                },
                itemBuilder: (BuildContext context, int index) {

                  // TODO: Widget1つにまとめる
                  if (taskService.taskList[index].isDone) {
                    return Dismissible(
                      key: Key(taskService.taskList[index].documentId),
                      background: Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // タスクを削除
                        taskService.deleteTask(taskService.taskList[index].documentId);
                      },

                      child: Column (
                        children: [
                          CheckboxListTile(
                            value: taskService.taskList[index].isDone,
                            onChanged: (value) {
                              taskService.switchStateChildTaskData(taskService.taskList[index].documentId, value);
                            },
                            title: Text(
                              taskService.taskList[index].title,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough
                              ),
                            ),
                          ),
                          Divider(),
                        ]
                      ),
                    );
                  } else {
                    return Dismissible(
                      key: Key(taskService.taskList[index].documentId),
                      background: Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // タスクを削除
                        taskService.deleteTask(taskService.taskList[index].documentId);
                      },

                      child: Column (
                        children: [
                          CheckboxListTile(
                            value: taskService.taskList[index].isDone,
                            onChanged: (value) {
                              taskService.switchStateChildTaskData(taskService.taskList[index].documentId, value);
                            },
                            title: Text(
                              taskService.taskList[index].title,
                            ),
                          ),
                          Divider(),
                        ]
                      ),
                    );
                  }
                },
                itemCount: taskService.taskList.length,
              ),
            ),
            Container(
              height: 16.0,
              color: Theme.of(context).primaryColor,
            ),

            Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: 16.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "タスクを追加"
                        ),
                        onSubmitted: (String value) {
                          if (value.trim().isEmpty) {
                            return;
                          }

                          setState(() {

                            taskService.addTask(value);
                            _controller.clear();
                          });

                        },
                      ),
                    ),
                  ),
                  Container(width: 16.0),
                ],
              ),
            ),

            Container(
              height: 16.0,
              color: Theme.of(context).primaryColor,
            ),

            AdmobBanner(
                adUnitId: AdMobService().getBannerAdUnitId(),
                adSize: AdmobBannerSize(
                  width: MediaQuery.of(context).size.width.toInt(),
                  height: AdMobService().getHeight(context).toInt(),
                  name: 'SMART_BANNER',
                )
            ),
          ],
        ),
      ),
    );
  }
}