import 'package:flutter/material.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/service/event_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/widget/event_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  final List<Room> rooms;
  const CalendarScreen({ super.key, required this.rooms });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  EventService eventService = EventService();
  bool isLoadingEvents = true;
  bool isLoadingRooms = true;

  @override
  void initState() {
    eventService.getEvents().then((value) {
      eventService.getAppointments();
      if (mounted) setState(() => isLoadingEvents = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return isLoadingEvents ? const Center(child: CircularProgressIndicator()) : SfCalendar(
      allowedViews: const [CalendarView.day, CalendarView.workWeek, CalendarView.month, CalendarView.timelineWorkWeek, CalendarView.schedule],
      allowViewNavigation: true,
      showNavigationArrow: true,
      showDatePickerButton: true,
      view: CalendarView.day,
      dataSource: AppointmentDataSource(eventService.appointments),
      onTap: (CalendarTapDetails details) {
        if (details.targetElement == CalendarElement.calendarCell) {
          _showAddEventDialog(details.date!);
        } else if (details.targetElement == CalendarElement.appointment) {
          _showRemoveEventDialog(details.appointments!.first);
        }
      },
      allowDragAndDrop: true,
      timeSlotViewSettings: const TimeSlotViewSettings(
        startHour: 9,
        endHour: 20,
        nonWorkingDays: <int>[DateTime.sunday, DateTime.saturday]
      ),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
      ),
    );
  }

  void _showAddEventDialog(DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (context) {
        return EventDialog(selectedDate: selectedDate, rooms: widget.rooms);
      },
    ).then((value) {
      if (value != null) {
        setState(() => eventService.appointments.add(value));
      }
    });
  }

  void _showRemoveEventDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return Utils().showConfirmationDialog(context, 'Eliminar Evento', '¿Estás seguro de que quieres eliminar este evento?');
      },
    ).then((value) {
      if (value) {
        setState(() => eventService.appointments.remove(appointment));
      }
    });
  }
}


class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}