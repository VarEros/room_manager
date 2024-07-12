import 'package:room_manager/model/room.dart';

class RoomService {
  List<Room> rooms = [];

  Future <void> getRooms() async {
    return Future.delayed(const Duration(seconds: 2), () {
      rooms = [    
        Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, idArea: 1),
        Room(id: 2, name: 'Room 2', description: 'Room 2 description', capacity: 10, idArea: 2),
        Room(id: 3, name: 'Room 3', description: 'Room 3 description', capacity: 10, idArea: 3),
      ];
    });
  }

  emptyRoom() => Room(id: 0, name: '', description: '', capacity: 0, idArea: 1);

  //save room
  Future<void> saveRoom(Room room) async {
    return Future.delayed(const Duration(seconds: 2));
  }
}