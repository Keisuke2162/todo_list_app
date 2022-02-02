import 'package:check_list_app/theme/theme_type.dart';
import 'package:flutter/material.dart';

class ThemeColorPage extends StatefulWidget {

  @override
  _ThemeColorPage createState() => _ThemeColorPage();
}

class _ThemeColorPage extends State<ThemeColorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("テーマカラー"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 8),
        child: ListView.builder(
          itemExtent: 72.0,
          itemCount: themeColors.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  // color: themeColors[index].color,
                  child: ListTile(
                    trailing: Container(
                      width: 56.0,
                      color: themeColors[index].color,
                    ),
                    title: Text(themeColors[index].name),
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

