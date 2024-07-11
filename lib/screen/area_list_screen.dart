import 'package:flutter/material.dart';
import 'package:room_manager/model/area.dart';
import 'package:room_manager/service/area_service.dart';
import 'package:room_manager/widget/area_elem_widget.dart';

class AreaListScreen extends StatelessWidget {
  const AreaListScreen({ super.key });

  @override
  Widget build(BuildContext context){
    final List<Area> areas = AreaService().areas;

    return ListView(
      children: areas.map((area) => AreaElemWidget(area: area)).toList(),
    );
  }
}