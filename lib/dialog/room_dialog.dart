import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
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
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AreaService areaService = AreaService();
  late final bool isNew;
  bool isLoading = true;

  @override
  void initState() {
    isNew = widget.room.id == 0;
    areaService.getAreas().then((value) => setState(() => isLoading = false));
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;

    return isLoading ? const Center(child: CircularProgressIndicator()) :
    AlertDialog(
      elevation: 10,
      title: Text(isNew ? 'Agregar Sala' : 'Editar Sala'),
      content: SizedBox(
        width: dialogWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                initialValue: widget.room.name,
                onChanged: (value) => setState(() => widget.room.name = value),
                validator: (value) => value!.isEmpty ? 'Porfavor, introduzca un nombre' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Descripción'),
                initialValue: widget.room.description,
                onChanged: (value) => setState (() => widget.room.description = value),
                validator: (value) => value!.isEmpty ? 'Por favor, introduzca una descripción' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Capacidad'),
                initialValue: widget.room.capacity.toString(),
                onChanged: (value) => setState(() => widget.room.capacity = int.tryParse(value) ?? 0),
                validator: (value) => value!.isEmpty ? 'Por favor, introduzca la capacidad de la sala' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              DropdownButton<int>(
                isExpanded: true,
                value: isNew ? 1 : widget.room.area.id,
                items: areaService.areas.map((Area area) {
                  return DropdownMenuItem<int>(
                    value: area.id,
                    child: Text(area.name),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() => widget.room.area.id = newValue!);
                },
              ),
              const SizedBox(height: 10),
              MaterialColorPicker(
                alignment: WrapAlignment.spaceEvenly,
                onColorChange: (value) =>  widget.room.color = value.value,
                selectedColor: Color(widget.room.color),
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
          onPressed: formKey.currentState != null && formKey.currentState!.validate() ? () => Navigator.of(context).pop(widget.room)  : null ,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
