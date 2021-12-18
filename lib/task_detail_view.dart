import 'package:check_list_app/task_model.dart';
import 'package:check_list_app/test_data.dart';
import 'package:flutter/material.dart';

class TaskDetailView extends StatefulWidget {

  TaskDetailView(this.task);
  List<Task> task;

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

    return Scaffold(
      appBar: AppBar(
        title: Text("TaskDetailView"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (widget.task[index].isDone) {
                  return CheckboxListTile(
                    value: widget.task[index].isDone,
                    onChanged: (value) {
                      setState(() => widget.task[index].isDone = value);

                      // TODO: ローカルデータを更新
                    },
                    title: Text(
                      widget.task[index].title,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  );
                } else {
                  return CheckboxListTile(
                    value: widget.task[index].isDone,
                    onChanged: (value) {
                      setState(() => widget.task[index].isDone = value);

                      // TODO: ローカルデータを更新
                    },
                    title: Text(
                      widget.task[index].title,
                      style: TextStyle(
                      ),
                    ),
                  );
                }
              },
              itemCount: widget.task.length,
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

                    Task newTask = Task(value, false);
                    setState(() {
                      widget.task.add(newTask);
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