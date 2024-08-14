import 'package:flutter/material.dart';
import 'package:room_manager/service/docent_service.dart';
import 'package:room_manager/service/event_service.dart';
import 'package:room_manager/service/room_service.dart';
import 'package:room_manager/utils.dart';
import 'package:room_manager/dialog/event_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  final int areaId;
  const CalendarScreen({ super.key, required this.areaId });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  EventService eventService = EventService();
  RoomService roomService = RoomService();
  DocentService docentService = DocentService();
  bool isLoading = true;
  final ValueNotifier<bool> isChangesNotifier = ValueNotifier<bool>(false);

  loadData() {
    setState(() => isLoading = true);
    eventService.changesEvents.clear();
    print(widget.areaId);
    roomService.getRoomsByArea(widget.areaId).then((value) {
      docentService.getDocents().then((value) {
        eventService.getEventsByAreaId(widget.areaId).then((value) {
          eventService.getAppointments();
          if (mounted) setState(() => isLoading = false);
        });
      });
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    isChangesNotifier.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CalendarScreen oldWidget) {
    if (oldWidget.areaId != widget.areaId) {
      loadData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context){
    return isLoading ? const Center(child: CircularProgressIndicator()) : Stack(
      children: [
        SfCalendar(
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
              _showEditEventDialog((details.appointments!.first as Appointment).id as int);
            } 
          },
          allowAppointmentResize: true,
          allowDragAndDrop: true,
          onDragEnd: (AppointmentDragEndDetails details) => _handleAppointmentChanges(details.appointment as Appointment),
          onAppointmentResizeEnd: (AppointmentResizeEndDetails details ) => _handleAppointmentChanges(details.appointment as Appointment),
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 9,
            endHour: 20,
            nonWorkingDays: <int>[DateTime.sunday, DateTime.saturday]
          ),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isChangesNotifier,
          builder: (context, isChanges, child) {
            return isChanges ? Positioned(
              bottom: 16,
              left: 16,
              child: FloatingActionButton.extended(
                onPressed: _saveChanges,
                label: const Text('Guardar Cambios'),
                icon: const Icon(Icons.save),
              ),
            ) : Container();
          },
        ),
      ],
    );
  }

  void _saveChanges() {
    eventService.saveEvents().then((value) {
      print(eventService.changesEvents);
      Utils().showSuccessNotification(context, 'Update');
      isChangesNotifier.value = false;
      loadData();
    });
  }

  void _showAddEventDialog(DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (context) {
        return EventDialog(event: eventService.emptyEvent(selectedDate), rooms: roomService.rooms, docents: docentService.docents);
      },
    ).then((value) {
      if (value != null) {
        setState(() { 
          value.id = eventService.events.length + eventService.changesEvents.length + 1;
          eventService.addChangeEvent(value);
          eventService.appointments.add(eventService.getAppointmentFromEvent(value));
          isChangesNotifier.value = true;
        });
      }
    });
  }

  void _showEditEventDialog(int idAppointment) {
    final event = eventService.changesEvents.firstWhere((event) => event.id == idAppointment, orElse: () => eventService.events.firstWhere((event) => event.id == idAppointment));
    
    showDialog(
      context: context,
      builder: (context) {
        return EventDialog(event: event, rooms: roomService.rooms, docents: docentService.docents);
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          eventService.addChangeEvent(value);
          eventService.replaceAppointment(eventService.getAppointmentFromEvent(value));
          isChangesNotifier.value = true;
        });
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
        setState(() {
          eventService.appointments.remove(appointment);
          isChangesNotifier.value = true;
        });
      }
    });
  }
  
  void _handleAppointmentChanges(Appointment appointment) {
    eventService.addChangeEventForAppointment(appointment);
    isChangesNotifier.value = true;
  }
}


class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
