import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/room.dart';

class RoomService {
  List<Room> rooms = [];

  Future <void> getRooms() async {
    return Future.delayed(const Duration(seconds: 2),   () {
      rooms = [    
        Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, area: Area(id: 1, name: 'Area 1', description: 'Area 1 description')),
        Room(id: 2, name: 'Room 2', description: 'Room 2 description', capacity: 10, area: Area(id: 2, name: 'Area 2', description: 'Area 2 description')),
        Room(id: 3, name: 'Room 3', description: 'Room 3 description', capacity: 10, area: Area(id: 3, name: 'Area 3', description: 'Area 3 description')),
      ];
    });
  }

  emptyRoom() => Room(id: 0, name: '', description: '', capacity: 0, area: null);

  //save room
  Future<void> saveRoom(Room room) async {
    return Future.delayed(const Duration(seconds: 2));
  }
}