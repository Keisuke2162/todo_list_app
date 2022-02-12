import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:check_list_app/user_data.dart';

class SettingMenuView extends StatelessWidget {

  final appSettingData = AppSettings();

  @override
  Widget build(BuildContext context) {

    final menuData = appSettingData.getMenuListData();

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),

      body: SafeArea(
        child: ListView.builder(
          itemExtent: 72.0,
          itemCount: menuData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  title: Text(menuData[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => menuData[index].page
                      )
                    );
                  },
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}