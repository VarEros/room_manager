import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/service/area_service.dart';

class RoomDialog extends StatefulWidget {
  final Room room;
  const RoomDialog({ super.key, required this.room});

  @override
  State<RoomDialog> createState() => _RoomDialogState();
}

class _RoomDialogState extends State<RoomDialog> {
  @override
  Widget build(BuildContext context){
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final List<Area> areas = AreaService().areas;

    return AlertDialog(
      elevation: 10,
      title: const Text('Edit Sala'),
      content: SizedBox(
        width: dialogWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                initialValue: widget.room.name,
                onChanged: (value) => widget.room.name = value,
                validator: (value) => value!.isEmpty ? 'Porfavor, introduzca un nombre' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Descripción'),
                initialValue: widget.room.description,
                onChanged: (value) => widget.room.description = value,
                validator: (value) => value!.isEmpty ? 'Por favor, introduzca una descripción' : null,
              ),
              const SizedBox(height: 10),
              DropdownButton<int>(
                isExpanded: true,
                value: widget.room.idArea,
                items: areas.map((Area area) {
                  return DropdownMenuItem<int>(
                    value: area.id,
                    child: Text(area.name),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() => widget.room.idArea = newValue!);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.of(context).pop(widget.room);
            } 
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}