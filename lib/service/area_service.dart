import 'package:room_manager/controllers/area.controller.dart';
import 'package:room_manager/model/area.dart';
import 'dart:convert';

class AreaService {
  List<Area> areas = [];

  dynamic getAreas() async {
    return areas = await AreaController().getAreas();
  }

  emptyArea() => Area(id: 0, name: '', description: '');

  Future<void> saveArea(Area area) async {
        if (area.id == 0){
            AreaController().saveArea(json.encode(area.toJson()));

        }
    else{

    AreaController().updateArea(area.id, json.encode(area.toJson()));
    }

  }
}
