import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/service/area_service.dart';

class RoomService {
  List<Room> rooms = [];

  Future <void> getRooms() async {
    return Future.delayed(const Duration(seconds: 1),   () {
      rooms = [    
        Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, color: Colors.blue.value, area: Area(id: 1, name: 'Area 1', description: 'Area 1 description')),
        Room(id: 2, name: 'Room 2', description: 'Room 2 description', capacity: 10, color: Colors.green.value, area: Area(id: 2, name: 'Area 2', description: 'Area 2 description')),
        Room(id: 3, name: 'Room 3', description: 'Room 3 description', capacity: 10, color: Colors.red.value, area: Area(id: 3, name: 'Area 3', description: 'Area 3 description')),
      ];
    });
  }

  Future getRoomsByArea(int idArea) async {
    return Future.delayed(const Duration(seconds: 1), () {  
      switch (idArea) {
        case 1:
          rooms = [
            Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, color: Colors.blue.value, area: Area(id: 1, name: 'Area 1', description: 'Area 1 description')),
          ];
          break;
        case 2:
          rooms = [
            Room(id: 2, name: 'Room 2', description: 'Room 2 description', capacity: 10, color: Colors.green.value, area: Area(id: 2, name: 'Area 2', description: 'Area 2 description')),
          ];
          break;
        case 3:
          rooms = [
            Room(id: 3, name: 'Room 3', description: 'Room 3 description', capacity: 10, color: Colors.red.value, area: Area(id: 3, name: 'Area 3', description: 'Area 3 description')),
            Room(id: 4, name: 'Room 4', description: 'Room 4 description', capacity: 10, color: Colors.yellow.value, area: Area(id: 3, name: 'Area 3', description: 'Area 3 description')),
          ];
          break;
        default:
          rooms = [];
      }
    });
  }

  emptyRoom() => Room(id: 0, name: '', description: '', capacity: 0, color: Colors.white.value, area: AreaService().emptyArea());

  //save room
  Future<void> saveRoom(Room room) async {
    return Future.delayed(const Duration(seconds: 1));
  }
}