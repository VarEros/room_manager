import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/docent.dart';
import 'package:room_manager/model/room.dart';

class Event {
  int id;
  String title;
  DateTime startDate;
  DateTime finishDate;
  Docent docent;
  Room room;

  Event({
    required this.id,
    required this.title,
    required this.startDate,
    required this.finishDate,
    required this.docent,
    required this.room
  });

 
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "startdate": startDate.toIso8601String(),
    "finishdate": finishDate.toIso8601String(),
    "iddocent": docent.id,
    "idroom": room.id,
  }; 


  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'],
    title: json['title'],
 startDate: DateTime.parse(json['startdate']), 
  finishDate: DateTime.parse(json['finishdate']),
    docent: Docent.fromJson(json['docent']),
    room: Room.fromJson(json['room']), 
  );

}


class EventResponse {
  final String message;
  final List<Event> data;

  EventResponse({
    required this.message,
    required this.data,
  });

factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
  message: json['message'] ?? '',
  data: List<Event>.from(
    json['data']?.map((event) => Event.fromJson(event)) ?? const [], 
  ),
);
}

