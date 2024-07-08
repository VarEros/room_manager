import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/widget/area_elem_widget.dart';

class AreaListScreen extends StatelessWidget {
  AreaListScreen({ super.key });
  final List<Area> _areas = [
    Area(id: 1, name: 'Meeting Room 1', description: 'This is a meeting room'),
    Area(id: 2, name: 'Meeting Room 2', description: 'This is a meeting room'),
    Area(id: 3, name: 'Meeting Room 3', description: 'This is a meeting room'),
    Area(id: 4, name: 'Meeting Room 4', description: 'This is a meeting room'),
    Area(id: 5, name: 'Meeting Room 5', description: 'This is a meeting room'),
  ];

  @override
  Widget build(BuildContext context){
    return ListView(
      children: _areas.map((area) => AreaElemWidget(area: area)).toList(),
    );
  }
}