import 'package:flutter/material.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/widget/room_elem_widget.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({ super.key });

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  RoomService roomService = RoomService();
  bool isLoading = true;

  @override
  void initState() {
    roomService.getRooms().then((value) => setState(() => isLoading = false));
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return isLoading ? 
      const Center(child: CircularProgressIndicator()) : ListView(
      children: roomService.rooms.map((room) => RoomElemWidget(room: room)).toList(),
    );
  }
}