import 'package:check_list_app/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChildDbProcess extends StatelessWidget {

  String uid;
  String documentId;
  ChildDbProcess(this.uid, this.documentId);

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
            return CircularProgressIndicator();

          default:

            taskService.init(snapshot.data.docs);
            return ChildTaskView(documentId);
        }
      },
    );
  }
}

// ignore: must_be_immutable
class ChildTaskView extends StatefulWidget {

  String documentId;
  ChildTaskView(this.documentId);

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
        title: Text('Todo'),
      ),

      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (taskService.taskList[index].isDone) {
                  return CheckboxListTile(
                    value: taskService.taskList[index].isDone,
                    onChanged: (value) {
                      // taskModel.switchStateChildTaskData(widget.documentId, taskService.taskList[index].documentId, value);

                    },
                    title: Text(
                      taskService.taskList[index].title,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  );
                } else {
                  return CheckboxListTile(
                    value: taskService.taskList[index].isDone,
                    onChanged: (value) {
                      // taskModel.switchStateChildTaskData(widget.documentId, childTasks[index].documentId, value);

                    },
                    title: Text(
                      taskService.taskList[index].title,
                      style: TextStyle(
                      ),
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
                      // taskModel.addChildTaskData(value, widget.documentId);
                      _controller.clear();
                    });

                  },
                ),
              ),
              SizedBox(width: 32.0),
            ],
          ),

          SizedBox(height: 24.0),

          Text(
            "広告枠",
            style: TextStyle(
                fontSize: 56.0
            ),
          ),
        ],
      ),
    );
  }
}

    /*
    return ChangeNotifierProvider(

      // 子タスクの一覧を取得
      create: (_) => TaskService()..fetchChildTaskData(widget.documentId),

      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
        ),

        // ignore: missing_return
        body: Consumer<TaskService> (builder: (context, model, child) {
          final List<ChildTask> childTasks = model.childTaskList;

          if (childTasks == null) {
            return Text("データの取得に失敗しました。");
          }

          return Column(
            children: [
              Flexible(
                child: ListView.builder(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (childTasks[index].isDone) {
                      return CheckboxListTile(
                        value: childTasks[index].isDone,
                        onChanged: (value) {

                          taskModel.switchStateChildTaskData(widget.documentId, childTasks[index].documentId, value);

                        },
                        title: Text(
                          childTasks[index].title,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      );
                    } else {
                      return CheckboxListTile(
                        value: childTasks[index].isDone,
                        onChanged: (value) {

                          taskModel.switchStateChildTaskData(widget.documentId, childTasks[index].documentId, value);

                        },
                        title: Text(
                          childTasks[index].title,
                          style: TextStyle(
                          ),
                        ),
                      );
                    }
                  },
                  itemCount: childTasks.length,
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
                          taskModel.addChildTaskData(value, widget.documentId);
                          _controller.clear();
                        });

                      },
                    ),
                  ),
                  SizedBox(width: 32.0),
                ],
              ),
              SizedBox(height: 24.0),
              Text(
                "広告枠",
                style: TextStyle(
                    fontSize: 56.0
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

     */