import 'package:check_list_app/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TaskDetailView extends StatefulWidget {

  String documentId;
  TaskDetailView(this.documentId);

  @override
  _TaskDetailView createState() => _TaskDetailView();
}

class _TaskDetailView extends State<TaskDetailView> {
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

    return ChangeNotifierProvider(

      // 子タスクの一覧を取得
      create: (_) => TaskModel()..fetchChildTaskData(widget.documentId),

      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
        ),

        // ignore: missing_return
        body: Consumer<TaskModel> (builder: (context, model, child) {
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
                          // setState(() => widget.task[index].isDone = value);

                          // TODO: ローカルデータを更新
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
                          // setState(() => widget.task[index].isDone = value);

                          // TODO: ローカルデータを更新
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

                        /*
                        ChildTask newTask = ChildTask(value, false);
                        setState(() {
                          widget.task.add(newTask);
                          _controller.clear();
                        });

                         */
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
}