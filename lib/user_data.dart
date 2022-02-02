import 'package:check_list_app/view/theme_color_page.dart';
import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {

  // 設定データ

  // テーマカラー
  Color mainColor = Colors.red;

  // アプリアイコン

  // フォント
}


// 設定メニューの一覧
class MenuData {
  String title;
  Widget page;

  MenuData(this.title, this.page);
}

List<MenuData> menuList = [
  MenuData('テーマカラー', ThemeColorPage()),
  MenuData('アイコン変更', ThemeColorPage())
];
