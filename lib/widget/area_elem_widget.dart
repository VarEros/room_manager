import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/widget/area_dialog.dart';

class AreaElemWidget extends StatelessWidget {
  final Area area;
  const AreaElemWidget({ super.key, required this.area});

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListTile(
      title: Text(area.name),
      subtitle: Text(area.description),
      onTap: () {
        showDialog(
          context: context, 
          builder: (context) => AreaDialog(area: area)
        ).then((value) {
          if (value != null) {
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
        });
      },
    );
  }
}