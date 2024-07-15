import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

class Utils extends ChangeNotifier {
  static const pages = ['Calendario', 'Areas', 'Salas', 'Ajustes'];
  static final map = {
    'Update': {'title': 'Cambios guardados','description': 'Los cambios se han guardado correctamente'},
    'Create': {'title': 'Elemento creado','description': 'El elemento se ha creado correctamente'}
  };

  String getAppbarTitle(int pageIndex, String? areaName) {
    if (pageIndex == 0 && areaName != null) return 'Calendario de $areaName';
    return pages[pageIndex];
  }

  showSuccessNotification(BuildContext context, String message) {
    Size size = MediaQuery.of(context).size;
    ElegantNotification.success(
      title: Text(map[message]?['title'] as String , style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(map[message]?['description'] as String),
      position: Alignment.bottomLeft,
      animation: AnimationType.fromLeft,
      showProgressIndicator: false,
      displayCloseButton: false,
      height: size.height * 0.08,
      width: size.width * 0.3,
    ).show(context);
  }
}