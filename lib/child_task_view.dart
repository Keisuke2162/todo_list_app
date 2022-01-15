import 'package:admob_flutter/admob_flutter.dart';
import 'package:check_list_app/child_task_service.dart';
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

      stream: taskService.dataPath.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            // return CircularProgressIndicator();
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
            Flexible(
              child: ListView.builder(
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
                              style: TextStyle(
                              ),
                            ),
                          ),
                        ]
                      ),
                    );
                  }
                },
                itemCount: taskService.taskList.length,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 32.0),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
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
                SizedBox(width: 32.0),
              ],
            ),

            SizedBox(height: 24.0),

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