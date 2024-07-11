import 'package:flutter/material.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/widget/room_elem_widget.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({ super.key });

  @override
  Widget build(BuildContext context){
    final rooms = RoomService().rooms;

    return ListView(
      children: rooms.map((room) => RoomElemWidget(room: room)).toList(),
    );
  }
}