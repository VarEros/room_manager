import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/service/area_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/widget/room_dialog.dart';

class RoomElemWidget extends StatelessWidget {
  final AreaService areaService;
  final Room room;
  const RoomElemWidget({ super.key, required this.room, required this.areaService});

  @override
  Widget build(BuildContext context){
    Utils utils = Utils();
    final areas = AreaService().areas;

    return ListTile(
      // leading with circle room capacity
      leading: CircleAvatar(
        child: Text(room.capacity.toString()),
      ),
      title: Text(room.name),
      subtitle: Text(room.description),
      trailing: Text(areas.firstWhere((element) => element.id == room.idArea).name),
      onTap: () {
        showDialog(
          context: context, 
          builder: (context) => RoomDialog(room: room)
        ).then((value) {
          if (value != null) {
            utils.showSuccessNotification(context);
          }
        });
      },
    );
  }
}