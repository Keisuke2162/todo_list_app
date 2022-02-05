import 'package:check_list_app/app_icon/icons_data.dart';
import 'package:flutter/material.dart';

class AppIconPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("アプリアイコン"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemExtent: 72.0,
          itemCount: appIconDataList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  // color: themeColors[index].color,
                  child: ListTile(
                    trailing: Container(
                      width: 56.0,
                      child: Image(
                        image: appIconDataList[index].iconImage,
                        width: 56.0,
                      ),
                    ),
                    title: Text(appIconDataList[index].name),
                    onTap: () => {

                    },
                  ),
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