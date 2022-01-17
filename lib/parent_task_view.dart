import 'package:admob_flutter/admob_flutter.dart';
import 'package:check_list_app/auth_service.dart';
import 'package:check_list_app/child_task_view.dart';
import 'package:check_list_app/parent_task_service.dart';
import 'package:check_list_app/service/admob.dart';
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

      stream: taskService.dataPath.orderBy('createdAt').snapshots(),
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
        title: Icon(Icons.check),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: taskService.taskList.length,
                itemBuilder: (BuildContext context, int index) {
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
                      // スワイプでタスクを削除する
                      taskService.deleteTask(taskService.taskList[index].documentId);
                    },

                    child: Column (
                      children: [
                        ListTile (

                          title: Text(taskService.taskList[index].title),
                          onTap: () => {

                            // 子タスク一覧画面に遷移（親タスクのドキュメントIDを渡す）
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChildDbProcess(taskService.uid, taskService.taskList[index].documentId, taskService.taskList[index].title)),
                            )

                          },
                        ),
                        Divider(),
                      ]
                    ),
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
                      hintText: "タイトルを追加"
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
      )
    );
  }
}