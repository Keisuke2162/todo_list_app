import 'dart:io';
import 'package:flutter/material.dart';

class AdMobService {

  String getBannerAdUnitId() {

    if (Platform.isAndroid) {
      return 'ca-app-pub-6087556183712349/8582529619';

    } else if (Platform.isIOS) {
      return 'ca-app-pub-6087556183712349/1641539139';

    }

    return null;
  }

  double getHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final percent = (height * 0.06).toDouble();

    return percent;
  }
}