import 'package:flutter/material.dart';

enum ThemeType {
  red,
  pink,
  purple,

}

Map<String, Color> themeType = {
  'red': Colors.red,
  'pink': Colors.pink,
  'purple': Colors.purple,
  'deepPurple': Colors.deepPurple,
  'indigo': Colors.indigo,
  'blue': Colors.blue,
  'lightBlue': Colors.lightBlue,
  'cyan': Colors.cyan,
  'teal': Colors.teal,
  'green': Colors.green,
  'lightGreen': Colors.lightGreen,
  'lime': Colors.lime,
  'yellow': Colors.yellow,
  'amber': Colors.amber,
  'orange': Colors.orange,
  'deepOrange': Colors.deepOrange,
  'brown': Colors.brown,
  'grey': Colors.grey,
  'blueGrey': Colors.blueGrey,
};


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