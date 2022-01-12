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
                      taskService.switchStateChildTaskData(taskService.taskList[index].documentId, value);
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
                      taskService.switchStateChildTaskData(taskService.taskList[index].documentId, value);
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