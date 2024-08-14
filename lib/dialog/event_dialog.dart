import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:room_manager/model/docent.dart';
import 'package:room_manager/model/event.dart';
import 'package:room_manager/model/room.dart';

class EventDialog extends StatefulWidget {
  final Event event;
  final List<Room> rooms;
  final List<Docent> docents;
  const EventDialog({ super.key, required this.event, required this.rooms, required this.docents});

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  
  final TextEditingController eventController = TextEditingController();
  late Duration _duration;
  late Event newEvent;
  late bool isNew;
  late int idDocent;
  late int idRoom;

  @override
  void initState() {
    eventController.text = widget.event.title;
    _duration = widget.event.finishDate.difference(widget.event.startDate);
    isNew = widget.event.id == 0;
    if (!isNew) {
      idDocent = widget.event.docent.id;
      idRoom = widget.event.room.id;
    } else {
      idDocent = widget.docents.first.id;
      idRoom = widget.rooms.first.id;
    }
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
            value: idRoom,
            items: widget.rooms.map((room) {
              return DropdownMenuItem<int>(
                value: room.id,
                child: Text(room.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() => idRoom = newValue!);
            },
          ),
          const SizedBox(height: 10),
          DropdownButton<int>(
            isExpanded: true,
            value: idDocent,
            items: widget.docents.map((docent) {
              return DropdownMenuItem(
                value: docent.id,
                child: Text(docent.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() => idDocent = newValue!);
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
              newEvent = Event(
                id: widget.event.id,
                title: eventTitle,
                startDate: widget.event.startDate,
                finishDate: widget.event.startDate.add(_duration),
                docent: widget.docents.firstWhere((docent) => docent.id == idDocent),
                room: widget.rooms.firstWhere((room) => room.id == idRoom),
              );
            }
            Navigator.pop(context, newEvent);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}