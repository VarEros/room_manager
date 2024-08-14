import 'package:flutter/material.dart';
import 'package:room_manager/dialog/room_dialog.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/utils.dart';
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
    loadData();
    super.initState();
  }

  loadData() {
    setState(() => isLoading = true);
    if (widget.areaId == null) {
      roomService.getRooms().then((value) {
        if (mounted) setState(() => isLoading = false);
      });
    } else {
      roomService.getRoomsByArea(widget.areaId!).then((value) {
        if (mounted) setState(() => isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return isLoading ? 
      const Center(child: CircularProgressIndicator()) : Stack(
      children: [
        ListView(
          children: roomService.rooms.map((room) => RoomElemWidget(room: room, onTap: loadData)).toList(),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return RoomDialog(room: RoomService().emptyRoom());
                }
              ).then((value) {
                if (value != null) {
                  RoomService().saveRoom(value).then((_) {
                    loadData();
                    Utils().showSuccessNotification(context, 'Create');
                  });
                }
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
      );
  }
}