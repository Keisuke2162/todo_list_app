import 'package:check_list_app/auth_service.dart';
import 'package:check_list_app/task_detail_view.dart';
import 'package:check_list_app/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParentDbProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final taskService = Provider.of<ParentTaskService>(context);

    taskService.uid = authService.user.uid;

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
            return ParentTaskView();
        }
      },
    );
  }
}

class ParentTaskView extends StatefulWidget {

  @override
  _ParentTaskView createState() => _ParentTaskView();
}

class _ParentTaskView extends State<ParentTaskView> {
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
    final taskService = Provider.of<ParentTaskService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("TASK"),
      ),

      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: taskService.taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile (

                  title: Text(taskService.taskList[index].title),
                  onTap: () => {

                    // 子タスク一覧画面に遷移（親タスクのドキュメントIDを渡す）
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => TaskDetailView(taskService.taskList[index].documentId)),
                      MaterialPageRoute(builder: (context) => ChildDbProcess(taskService.uid, taskService.taskList[index].documentId)),
                    )

                  },
                );
              },
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

                      // 親タスクを追加
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
      )
    );
  }
}