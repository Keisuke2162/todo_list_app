import 'package:check_list_app/app_icon/icons_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

class AppIconPage extends StatefulWidget {
  @override
  _AppIconPage createState() => _AppIconPage();
}

class _AppIconPage extends State<AppIconPage> {
  // アプリアイコン名
  String currentIconName = "?";

  @override
  void initState() {
    super.initState();

    FlutterDynamicIcon.getAlternateIconName().then((value) {
      print("テスト：$value");
      setState(() {
        currentIconName = value ?? "`primary`";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    return Scaffold(
      // key: _scaffoldKey,
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
                  child: ListTile(
                    trailing: Container(
                      width: 56.0,
                      child: Image(
                        image: appIconDataList[index].iconImage,
                        width: 56.0,
                      ),
                    ),
                    title: Text(appIconDataList[index].name),
                    onTap: () async {
                      try {
                        if (await FlutterDynamicIcon.supportsAlternateIcons) {
                          await FlutterDynamicIcon.setAlternateIconName(appIconDataList[index].iconImageName);

                          FlutterDynamicIcon.getAlternateIconName().then((value) {
                            setState(() {
                              currentIconName = value ?? "`primary`";
                            });
                          });
                          return;
                        }
                      } on PlatformException {} catch (e) {
                        print("テスト：エラー");
                      }
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