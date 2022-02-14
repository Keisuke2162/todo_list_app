import 'dart:async';

import 'package:check_list_app/theme/theme_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

typedef ThemedWidgetBuilder = Widget Function(BuildContext context, ThemeData data);

typedef ThemeDataWithColorBuilder = ThemeData Function(MaterialColor primarySwatch);

class DynamicTheme extends StatefulWidget {
  const DynamicTheme({
    Key key,
    this.data,
    this.themedWidgetBuilder,
    this.defaultColor = Colors.blue,
    this.loadThemeColorOnStart = true,
  }) : super(key: key);

  // デフォルトのテーマカラー
  final Color defaultColor;

  // アプリ起動時にテーマカラーを読み込むかどうか
  final bool loadThemeColorOnStart;

  /// テーマ変更時に呼び出されるビルダー
  final ThemedWidgetBuilder themedWidgetBuilder;

  /// 最新のテーマカラーを返すコールバック
  final ThemeDataWithColorBuilder data;

  @override
  DynamicThemeState createState() => DynamicThemeState();

  static DynamicThemeState of(BuildContext context) {
    return context.findAncestorStateOfType<DynamicThemeState>();
  }
}

class DynamicThemeState extends State<DynamicTheme> {
  ThemeData _themeData;
  Color _color = Colors.blue;

  bool _shouldLoadThemeColor = true;

  // SharedPreference用のキー
  static const String _themeColorKey = 'theme_key';

  /// Get the current `ThemeData`
  ThemeData get themeData => _themeData;

  /// 現在のcolorを取得する
  Color get color => _color;

  @override
  void initState() {
    super.initState();
    _initVariables();
    _loadThemeColor();
  }

  /// Loads the brightness depending on the `loadBrightnessOnStart` value
  Future<void> _loadThemeColor() async {

    if(!_shouldLoadThemeColor) {
      return "";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loadColorStr = prefs.getString(_themeColorKey) ?? "blue";
    _color = themeType[loadColorStr];
    _themeData = widget.data(_color);

    if (mounted) {
      setState(() {});
    }

  }

  /// Initializes the variables
  void _initVariables() {
    _color = widget.defaultColor;
    _shouldLoadThemeColor = widget.loadThemeColorOnStart;
    _themeData = widget.data(_color);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = widget.data(_color);
  }

  @override
  void didUpdateWidget(DynamicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);

    _themeData = widget.data(_color);
  }

  /// 新しいテーマカラーを設定してツリーを再構築
  Future<void> setThemeColor(String newColor) async {
    setState(() {
      _color = color;
    });
    // 保存
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeColorKey, newColor);
  }

  /// Changes the theme using the provided `ThemeData`
  void setThemeData(ThemeData data) {
    setState(() {
      _themeData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _themeData);
  }
}