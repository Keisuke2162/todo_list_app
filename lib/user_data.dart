import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {

  // 設定データ

  // テーマカラー
  MaterialColor mainColor = Colors.cyan;

  // アプリアイコン

  // フォント
}

class TestData {

}

class MenuData {
  String title;
  // Widget page;

  MenuData(this.title);
}

List<MenuData> menuList = [MenuData('テーマカラー'), MenuData('アイコン変更')];