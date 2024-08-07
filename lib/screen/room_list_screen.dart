import 'package:flutter/material.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/widget/room_elem_widget.dart';

class RoomListScreen extends StatefulWidget {
  final int? areaId;
  const RoomListScreen({ super.key, this.areaId });

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  RoomService roomService = RoomService();
  bool isLoading = true;

  @override
  void initState() {
    if (widget.areaId == null) {
      roomService.getRooms().then((value) {
        if (mounted) setState(() => isLoading = false);
      });
    } else {
      roomService.getRoomsByArea(widget.areaId!).then((value) {
        if (mounted) setState(() => isLoading = false);
      });
    }
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