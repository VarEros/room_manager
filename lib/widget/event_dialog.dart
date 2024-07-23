import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:room_manager/model/room.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDialog extends StatefulWidget {
  final DateTime selectedDate;
  final List<Room> rooms;
  const EventDialog({ super.key, required this.selectedDate, required this.rooms });

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  
  final TextEditingController eventController = TextEditingController();
  Duration _duration = const Duration(hours: 1);
  late int selectedRoom;
  late Appointment newAppointment;

  @override
  void initState() {
    selectedRoom = widget.rooms.first.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: const Text('Agregar Evento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: eventController,
            decoration: const InputDecoration(label: Text('Titulo')),
          ),
          const SizedBox(height: 10),
          DropdownButton<int>(
            isExpanded: true,
            value: selectedRoom,
            items: widget.rooms.map((room) {
              return DropdownMenuItem<int>(
                value: room.id,
                child: Text(room.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() => selectedRoom = newValue!);
            },
          ),
          DurationPicker(
            lowerBound: const Duration(minutes: 15),
            upperBound: const Duration(hours: 4),
            duration: _duration,
            onChange: (val) => setState(() => _duration = val),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (eventController.text.isEmpty) return;
            final String eventTitle = eventController.text;
            if (eventTitle.isNotEmpty) {
              newAppointment = Appointment(
                subject: eventTitle,
                startTime: widget.selectedDate,
                endTime:  widget.selectedDate.add(_duration),
                color: Colors.green,
              );
            }
            Navigator.pop(context, newAppointment);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}