import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/docent.dart';
import 'package:room_manager/model/event.dart';
import 'package:room_manager/model/room.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventService {
  List<Event> events = [];
  List<Appointment> appointments = [];
  List<Event> changesEvents = [];

  Future getEvents() async {
    return Future.delayed(const Duration(seconds: 1), () {
      events = [
        Event(id: 1, title: 'Event 1', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), docent: Docent(id: 1, name: 'Docente 1'), room: Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, color: Color.getAlphaFromOpacity(10), area: Area(id: 1, name: 'Area 1'))),
      ];
    });
  }

  Future getEventsByAreaId(int areaId) async {
    return Future.delayed(const Duration(seconds: 1), () {
      if (areaId == 1) {
        events = [
          Event(id: 1, title: 'Event 1', startDate: DateTime.now().subtract(const Duration(hours: 10)), finishDate: DateTime.now().subtract(const Duration(hours: 8)), docent: Docent(id: 1, name: 'Docente 1'), room: Room(id: 1, name: 'Room 1', description: 'Room 1 description', capacity: 10, color: Colors.blue.value, area: Area(id: 1, name: 'Area 1'))),
        ];
      } else if (areaId == 2) {
        events = [
          Event(id: 2, title: 'Event 2', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), docent: Docent(id: 1, name: 'Docente 1'), room: Room(id: 2, name: 'Room 2', description: 'Room 2 description', capacity: 10, color: Colors.blue.value, area: Area(id: 2, name: 'Area 2'))),
          Event(id: 3, title: 'Event 3', startDate: DateTime.now(), finishDate: DateTime.now().add(const Duration(hours: 2)), docent: Docent(id: 1, name: 'Docente 1'), room: Room(id: 3, name: 'Room 3', description: 'Room 3 description', capacity: 10, color: Colors.blue.value, area: Area(id: 2, name: 'Area 2'))),
        ];
      } else {
        events = [];
      }

    });
  }

  Future saveEvents() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return true;
    });
  }

  getAppointments() {
    appointments = events.map((event) => getAppointmentFromEvent(event)).toList();
  }

  Appointment getAppointmentFromEvent(Event event) {
    return Appointment(
      id: event.id,
      startTime: event.startDate,
      endTime: event.finishDate,
      subject: '${event.title} - ${event.docent.name}',
      color: Color(event.room.color),
      isAllDay: false
    );
  }

  addChangeEvent(Event event) {
    int index = changesEvents.indexWhere((element) => element.id == event.id);
    if (index != -1) {
      changesEvents[index] = event;
    } else {
      changesEvents.add(event);
    }
  }

  Event getEventFromAppointmentForDragResize(Appointment appointment) {
    Event event = events.firstWhere((event) => event.id == appointment.id, orElse: () => changesEvents.firstWhere((event) => event.id == appointment.id));
    event.startDate = appointment.startTime;
    event.finishDate = appointment.endTime;
    return event;
  }

  addChangeEventForAppointment(Appointment appointment) {
    Event event = getEventFromAppointmentForDragResize(appointment);
    int index = changesEvents.indexWhere((element) => element.id == event.id);
    if (index != -1) {
      changesEvents[index] = event;
    } else {
      changesEvents.add(event);
    }
  }

  replaceAppointment(Appointment appointment) {
    int index = appointments.indexWhere((element) => element.id == appointment.id);
    appointments[index] = appointment;
  }

  emptyEvent(DateTime date) {
    return Event(id: 0, title: '', startDate: date, finishDate: date.add(const Duration(hours: 1)), docent: Docent(id: 1, name: 'Docente 1'), room: Room(id: 1, name: '', description: '', capacity: 0, color: 0, area: Area(id: 1, name: '')));
  }
}