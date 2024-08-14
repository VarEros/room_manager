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


  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "capacity": capacity,
    "color": color.toString(),
    "idarea": area.id
  };

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    capacity: json['capacity'],
    color: int.parse(json['color']), 
    area: Area.fromJson(json['area']),
  );

}

class RoomResponse {
  final String message;
  final List<Room> data;

  RoomResponse({
    required this.message,
    required this.data,
  });

factory RoomResponse.fromJson(Map<String, dynamic> json) => RoomResponse(
  message: json['message'] ?? '', // Use empty string if message is null
  data: List<Room>.from(
    json['data']?.map((room) => Room.fromJson(room)) ?? const [], // Use empty list if data is null
  ),
);
}

