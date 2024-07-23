import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/event.dart';
import 'package:room_manager/model/room.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventService {
  List<Event> events = [];
  List<Appointment> appointments = [];

  Future getEvents() async {
    return Future.delayed(const Duration(seconds: 1), () {
      events = [
        Event(id: 1, title: 'Event 1', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), room: Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, color: Color.getAlphaFromOpacity(10), area: Area(id: 1, name: 'Area 1'))),
      ];
    });
  }

  Future getEventsByAreaId(int areaId) async {
    return Future.delayed(const Duration(seconds: 1), () {
      if (areaId == 1) {
        events = [
          Event(id: 1, title: 'Event 1', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), room: Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, color: Color.getAlphaFromOpacity(10), area: Area(id: 1, name: 'Area 1'))),
        ];
      } else if (areaId == 2) {
        events = [
          Event(id: 2, title: 'Event 2', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), room: Room(id: 2, name: 'Room 2', description: 'Room 2 description', capacity: 10, color: Color.getAlphaFromOpacity(10), area: Area(id: 2, name: 'Area 2'))),
          Event(id: 3, title: 'Event 3', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), room: Room(id: 3, name: 'Room 3', description: 'Room 3 description', capacity: 10, color: Color.getAlphaFromOpacity(10), area: Area(id: 2, name: 'Area 2'))),
        ];
      } else {
        events = [];
      }

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