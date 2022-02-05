
import 'package:flutter/cupertino.dart';

class AppIcon {
  String name;
  AssetImage iconImage;

  AppIcon(this.name, this.iconImage);
}

List<AppIcon> appIconDataList = [
  AppIcon('red', AssetImage("lib/assets/icon_red.png")),
  AppIcon('pink', AssetImage('lib/assets/icon_pink.png')),
  AppIcon('purple', AssetImage('lib/assets/icon_purple.png')),
  AppIcon('deepPurple', AssetImage('lib/assets/icon_deepPurple.png')),
  AppIcon('indigo', AssetImage('lib/assets/icon_indigo.png')),
  AppIcon('blue', AssetImage('lib/assets/icon_blue.png')),
  AppIcon('lightBlue', AssetImage('lib/assets/icon_lightBlue.png')),
  AppIcon('cyan', AssetImage('lib/assets/icon_cyan.png')),
  AppIcon('teal', AssetImage('lib/assets/icon_teal.png')),
  AppIcon('green', AssetImage('lib/assets/icon_green.png')),
  AppIcon('lightGreen', AssetImage('lib/assets/icon_lightGreen.png')),
  AppIcon('lime', AssetImage('lib/assets/icon_lime.png')),
  AppIcon('yellow', AssetImage('lib/assets/icon_yellow.png')),
  AppIcon('amber', AssetImage('lib/assets/icon_amber.png')),
  AppIcon('orange', AssetImage('lib/assets/icon_orange.png')),
  AppIcon('deepOrange', AssetImage('lib/assets/icon_deepOrange.png')),
  AppIcon('brown', AssetImage('lib/assets/icon_brown.png')),
  AppIcon('grey', AssetImage('lib/assets/icon_grey.png')),
  AppIcon('blueGrey', AssetImage('lib/assets/icon_blueGrey.png')),
];