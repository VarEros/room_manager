import 'package:flutter/material.dart';
import 'package:room_manager/model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventService {
  List<Event> events = [];
  List<Appointment> appointments = [];

  Future getEvents() async {
    return Future.delayed(const Duration(seconds: 1), () {
      events = [
        Event(id: 1, title: 'Event 1', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), roomId: 1),
      ];
    });
  }

  getAppointments() {
    appointments = events.map((event) => Appointment(
      startTime: event.startDate,
      endTime: event.finishDate,
      subject: event.title,
      color: Colors.green,
      isAllDay: false
    )).toList();
  }
}