class Event {
  int id;
  String title;
  DateTime startDate;
  DateTime finishDate;
  int roomId;

  Event({
    required this.id,
    required this.title,
    required this.startDate,
    required this.finishDate,
    required this.roomId
  });
}