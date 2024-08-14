import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:room_manager/controllers/room.controller.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/service/area_service.dart';

class RoomService {
  List<Room> rooms = [];

Future<List<Room>> getRooms() async {
  final roomData = await RoomController().getRooms();
  rooms = roomData.data;
  return rooms;
}

  Future getRoomsByArea(int idArea) async {
    final roomData = await RoomController().getRoomsByAreaId(idArea);
    rooms = roomData.data;
    return rooms;
  }

  emptyRoom() => Room(id: 0, name: '', description: '', capacity: 0, color: Colors.white.value, area: AreaService().emptyArea());

  //save room
  Future<void> saveRoom(Room room) async {
    RoomController().saveRoom(json.encode(room.toJson()));
  }
}
