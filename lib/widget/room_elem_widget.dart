import 'package:flutter/material.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/widget/room_dialog.dart';

class RoomElemWidget extends StatelessWidget {
  final Room room;
  const RoomElemWidget({ super.key, required this.room});

  @override
  Widget build(BuildContext context){
    Utils utils = Utils();

    return ListTile(
      // leading with circle room capacity
      leading: CircleAvatar(
        child: Text(room.capacity.toString()),
      ),
      title: Text(room.name),
      subtitle: Text(room.description),
      trailing: Text(room.area!.name),
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