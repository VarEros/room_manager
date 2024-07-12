import 'package:room_manager/model/area.dart';

class AreaService {
  List<Area> areas = [];

  Future<void> getAreas() async {
    return Future.delayed(const Duration(seconds: 2), () {
      areas = [
        Area(id: 1, name: 'Area 1', description: 'Area 1 description'),
        Area(id: 2, name: 'Area 2', description: 'Area 2 description'),
        Area(id: 3, name: 'Area 3', description: 'Area 3 description'),
      ];
    });
  }

  emptyArea() => Area(id: 0, name: '', description: '');

  //save area
  Future<void> saveArea(Area area) async {
    return Future.delayed(const Duration(seconds: 2), () {
      if (area.id == 0) {
        area.id = areas.length + 1;
        areas.add(area);
      } else {
        final index = areas.indexWhere((element) => element.id == area.id);
        areas[index] = area;
      }
    });
  }
}