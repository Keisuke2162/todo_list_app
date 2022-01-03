import 'package:check_list_app/task_detail_view.dart';
import 'package:check_list_app/task_model.dart';
import 'package:check_list_app/test_data.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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

    final TaskModel taskModel = TaskModel();

    return ChangeNotifierProvider<TaskModel>(

      // 親タスクの一覧を取得
      create: (_) => TaskModel()..fetchParentTaskData(),

      child: Scaffold(
        appBar: AppBar(
          title: Text("TASK"),
        ),
        body: Consumer<TaskModel> (builder: (context, model, child) {


          final List<ParentTask> tasks = model.taskList;

          if (tasks == null) {
            return Text("データの取得に失敗しました。");
          }

          return Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {

                    // 子タスク一覧
                    List<ChildTask> childTasks = [];

                    return ListTile (

                      title: Text(tasks[index].title),
                      onTap: () => {

                        // 子タスク一覧画面に遷移（親タスクのドキュメントIDを渡す）
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TaskDetailView(tasks[index].documentId)),
                        )

                      },
                    );
                  },
                  itemCount: tasks.length,
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
                          taskModel.addParentTaskData(value);

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
      )
    );
  }
}