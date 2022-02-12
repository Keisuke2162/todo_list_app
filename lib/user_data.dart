import 'package:check_list_app/view/app_icon_page.dart';
import 'package:check_list_app/view/theme_color_page.dart';
import 'package:check_list_app/view/user_contact_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

/// アプリの設定データクラス
class AppSettings {

  // サイドメニューデータを取得
  List<MenuData> getMenuListData() {
    if(Platform.isIOS) {
      return iosMenuList;

    } else {
      return androidMenuList;

    }
  }
}


// 設定メニューの一覧
class MenuData {
  String title;
  Widget page;

  MenuData(this.title, this.page);
}

List<MenuData> iosMenuList = [
  MenuData('テーマカラー', ThemeColorPage()),
  MenuData('アイコン変更', AppIconPage()),
  MenuData('お問い合わせ', ContactPage()),
];

List<MenuData> androidMenuList = [
  MenuData('テーマカラー', ThemeColorPage()),
  MenuData('お問い合わせ', ContactPage()),
];
