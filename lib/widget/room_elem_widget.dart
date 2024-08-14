import 'package:flutter/material.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/dialog/room_dialog.dart';

class RoomElemWidget extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;
  const RoomElemWidget({ super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context){
    Utils utils = Utils();

    return ListTile(
      // leading with circle room capaci
      leading: CircleAvatar(
        backgroundColor: Color(room.color),
        child: Text(room.capacity.toString()),
      ),
      title: Text(room.name),
      subtitle: Text(room.description),
      trailing: Text(room.area.name),
      onTap: () {
        showDialog(
          context: context, 
          builder: (context) => RoomDialog(room: room)
        ).then((value) {
          if (value != null) {
            RoomService().saveRoom(value).then((_) {
              utils.showSuccessNotification(context, 'Update');
              onTap();
            });
          }
        });
      },
    );
  }
}