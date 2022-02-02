import 'package:flutter/material.dart';
import 'package:check_list_app/user_data.dart';

class SettingMenuView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),

      body: SafeArea(
        child: ListView.builder(
          itemExtent: 72.0,
          itemCount: menuList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  title: Text(menuList[index].title),
                  onTap: () => {

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