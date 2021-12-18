import 'package:check_list_app/task_detail_view.dart';
import 'package:check_list_app/task_model.dart';
import 'package:check_list_app/test_data.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text("ParentTaskView"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(testData[index].title),

                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskDetailView(testData[index].taskList)),
                    )
                  },
                );
              },
              itemCount: testData.length,
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

                    ParentTask newParentTask = ParentTask(value, []);
                    setState(() {
                      testData.add(newParentTask);
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