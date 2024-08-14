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
}