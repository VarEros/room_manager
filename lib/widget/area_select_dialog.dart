import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/service/area_service.dart';

class AreaSelectDialog extends StatefulWidget {
  final int? idArea;
  const AreaSelectDialog({ super.key, this.idArea});

  @override
  State<AreaSelectDialog> createState() => _AreaSelectDialogState();
}

class _AreaSelectDialogState extends State<AreaSelectDialog> {
  
  List<Area> areas = AreaService().areas;
  late Area selectedArea;
  
  @override
  void initState() {
    super.initState();

    selectedArea = areas.firstWhere((element) => element.id == widget.idArea, orElse: () => areas[0]);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cambiar Area'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Seleccione el area a visualizar'),
          DropdownButton<Area>(
            isExpanded: true,
            value: selectedArea,
            items: areas.map((Area area) {
              return DropdownMenuItem<Area>(
                value: area,
                child: Text(area.name),
              );
            }).toList(),
            onChanged: (Area? newValue) {
              setState(() => selectedArea = newValue!);
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedArea);
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}