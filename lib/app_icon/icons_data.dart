
import 'package:flutter/cupertino.dart';

class AppIcon {
  String name;
  AssetImage iconImage;
  String iconImageName;

  AppIcon(this.name, this.iconImage, this.iconImageName);
}

List<AppIcon> appIconDataList = [
  AppIcon('red', AssetImage("lib/assets/icon_red.png"), 'icon_red_2'),
  AppIcon('pink', AssetImage('lib/assets/icon_pink.png'), 'icon_pink_2'),
  AppIcon('purple', AssetImage('lib/assets/icon_purple.png'), 'icon_purple_2'),
  AppIcon('deepPurple', AssetImage('lib/assets/icon_deepPurple.png'), 'icon_deepPurple_2'),
  AppIcon('indigo', AssetImage('lib/assets/icon_indigo.png'), 'icon_indigo_2'),
  AppIcon('blue', AssetImage('lib/assets/icon_blue.png'), 'icon_blue_2'),
  AppIcon('lightBlue', AssetImage('lib/assets/icon_lightBlue.png'), 'icon_lightBlue_2'),
  AppIcon('cyan', AssetImage('lib/assets/icon_cyan.png'), 'icon_cyan_2'),
  AppIcon('teal', AssetImage('lib/assets/icon_teal.png'), 'icon_teal_2'),
  AppIcon('green', AssetImage('lib/assets/icon_green.png'), 'icon_green_2'),
  AppIcon('lightGreen', AssetImage('lib/assets/icon_lightGreen.png'), 'icon_lightGreen_2'),
  AppIcon('lime', AssetImage('lib/assets/icon_lime.png'), 'icon_lime_2'),
  AppIcon('yellow', AssetImage('lib/assets/icon_yellow.png'), 'icon_yellow_2'),
  AppIcon('amber', AssetImage('lib/assets/icon_amber.png'), 'icon_amber_2'),
  AppIcon('orange', AssetImage('lib/assets/icon_orange.png'), 'icon_orange_2'),
  AppIcon('deepOrange', AssetImage('lib/assets/icon_deepOrange.png'), 'icon_deepOrange_2'),
  AppIcon('brown', AssetImage('lib/assets/icon_brown.png'), 'icon_brown_2'),
  AppIcon('grey', AssetImage('lib/assets/icon_grey.png'), 'icon_grey_2'),
  AppIcon('blueGrey', AssetImage('lib/assets/icon_blueGrey.png'), 'icon_blueGrey_2'),
];