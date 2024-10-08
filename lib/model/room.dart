import 'package:room_manager/model/area.dart';

class Room {
  int id;
  String name;
  String description;
  int capacity;
  int color;
  Area area;

  Room({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.capacity,
    required this.color,
    required this.area
  });
}