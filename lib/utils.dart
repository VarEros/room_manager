import 'package:flutter/material.dart';

class Utils extends ChangeNotifier {
  static const pages = ['Calendario', 'Areas', 'Ajustes'];

  String getAppbarTitle(int pageIndex, String? areaName) {
    if (pageIndex == 0 && areaName != null) return 'Calendario de $areaName';
    return pages[pageIndex];
  }
}