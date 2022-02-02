import 'package:flutter/material.dart';

/*
enum ColorType {
  blue,
  red,
  yellow,
}

extension ColorTypeExtension on ColorType {
  static final typeNames = {
    ColorType.blue: 'blue',
    ColorType.red: 'red'
  };
}

 */



// テーマカラーの一覧
class ThemeColor {
  String name;
  Color color;

  ThemeColor(this.name, this.color);
}

List<ThemeColor> themeColors = [
  ThemeColor('red', Colors.red),
  ThemeColor('pink', Colors.pink),
  ThemeColor('purple', Colors.purple),
  ThemeColor('deepPurple', Colors.deepPurple),
  ThemeColor('indigo', Colors.indigo),
  ThemeColor('blue', Colors.blue),
  ThemeColor('lightBlue', Colors.lightBlue),
  ThemeColor('cyan', Colors.cyan),
  ThemeColor('teal', Colors.teal),
  ThemeColor('green', Colors.green),
  ThemeColor('lightGreen', Colors.lightGreen),
  ThemeColor('lime', Colors.lime),
  ThemeColor('yellow', Colors.yellow),
  ThemeColor('amber', Colors.amber),
  ThemeColor('orange', Colors.orange),
  ThemeColor('deepOrange', Colors.deepOrange),
  ThemeColor('brown', Colors.brown),
  ThemeColor('grey', Colors.grey),
  ThemeColor('blueGrey', Colors.blueGrey),
];