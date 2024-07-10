import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';

class AreaSelectDialog extends StatefulWidget {
  final int? idArea;
  const AreaSelectDialog({ super.key, this.idArea});

  @override
  State<AreaSelectDialog> createState() => _AreaSelectDialogState();
}

class _AreaSelectDialogState extends State<AreaSelectDialog> {
  
  List<Area> areas = [
    Area(id: 1, name: 'Area 1', description: 'Area 1 Description'),
    Area(id: 2, name: 'Area 2', description: 'Area 2 Description'),
    Area(id: 3, name: 'Area 3', description: 'Area 3 Description'),
    Area(id: 4, name: 'Area 4', description: 'Area 4 Description'),
    Area(id: 5, name: 'Area 5', description: 'Area 5 Description'),
  ];

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