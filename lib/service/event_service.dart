import 'dart:ui';

import 'package:room_manager/model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventService {
  List<Event> events = [];
  List<Appointment> appointments = [];

  Future getEvents() async {
    return Future.delayed(const Duration(seconds: 2), () {
      events = [
        Event(id: 1, title: 'Event 1', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), color: 0xff123456),
      ];
    });
  }

  getAppointments() {
    appointments = events.map((event) => Appointment(
      startTime: event.startDate,
      endTime: event.finishDate,
      subject: event.title,
      color: Color(event.color),
      isAllDay: false
    )).toList();
  }
}