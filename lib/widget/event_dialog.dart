import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDialog extends StatelessWidget {
  final DateTime selectedDate;
  const EventDialog({ super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context){
    final TextEditingController eventController = TextEditingController();
    late Appointment newAppointment;

    return AlertDialog(
          title: const Text('Agregar Evento'),
          content: TextField(
            controller: eventController,
            decoration: const InputDecoration(hintText: 'Titulo'),
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