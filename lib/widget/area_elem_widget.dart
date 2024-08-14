import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/service/area_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/dialog/area_dialog.dart';

class AreaElemWidget extends StatelessWidget {
  final Area area;
  final VoidCallback onTap;
  const AreaElemWidget({ super.key, required this.area, required this.onTap});

  @override
  Widget build(BuildContext context){
    Utils utils = Utils();

    return ListTile(
      title: Text(area.name),
      subtitle: Text(area.description),
      onTap: () {
        showDialog(
          context: context, 
          builder: (context) => AreaDialog(area: area)
        ).then((value) {
          if (value != null) {
            AreaService().saveArea(area).then((value) {
              utils.showSuccessNotification(context, 'Update');
              onTap();
            });
          }
        });
      },
    );
  }
}