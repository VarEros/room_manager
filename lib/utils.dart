import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

class Utils extends ChangeNotifier {
  static const pages = ['Calendario', 'Areas', 'Salas', 'Ajustes'];

  String getAppbarTitle(int pageIndex, String? areaName) {
    if (pageIndex == 0 && areaName != null) return 'Calendario de $areaName';
    return pages[pageIndex];
  }

  showSuccessNotification(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ElegantNotification.success(
      title: const Text('Cambios guardados', style: TextStyle(fontWeight: FontWeight.bold)),
      description: const Text('Los cambios se han guardado correctamente'),
      position: Alignment.bottomLeft,
      animation: AnimationType.fromLeft,
      showProgressIndicator: false,
      displayCloseButton: false,
      height: size.height * 0.08,
      width: size.width * 0.3,
    ).show(context);
  }
}