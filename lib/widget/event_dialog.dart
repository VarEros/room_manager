import 'package:flutter/material.dart';
import 'package:room_manager/model/room.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDialog extends StatelessWidget {
  final DateTime selectedDate;
  final List<Room> rooms;
  const EventDialog({ super.key, required this.selectedDate, required this.rooms });

  @override
  Widget build(BuildContext context){
    print(rooms);
    final TextEditingController eventController = TextEditingController();
    int selectedRoom = rooms.first.id;
    late Appointment newAppointment;

    return AlertDialog(
          title: const Text('Agregar Evento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: eventController,
                decoration: const InputDecoration(hintText: 'Titulo'),
              ),
              DropdownButton<int>(
                isExpanded: true,
                value: selectedRoom,
                items: rooms.map((room) {
                  return DropdownMenuItem<int>(
                    value: room.id,
                    child: Text(room.name),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  selectedRoom = newValue!;
                },
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
                    startTime: selectedDate,
                    endTime:  selectedDate.add(const Duration(hours: 1)),
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