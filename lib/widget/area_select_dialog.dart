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
  AreaService areaService = AreaService();
  bool isLoading = true;
  late Area selectedArea;
  
  @override
  void initState() {
    super.initState();
    areaService.getAreas().then((value) { 
      setState(() => isLoading = false);
      selectedArea = areaService.areas.firstWhere((element) => element.id == widget.idArea, orElse: () => areaService.areas[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child: CircularProgressIndicator()) : AlertDialog(
      title: const Text('Cambiar Area'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Seleccione el area a visualizar'),
          DropdownButton<Area>(
            isExpanded: true,
            value: selectedArea,
            items: areaService.areas.map((Area area) {
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