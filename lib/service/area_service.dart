import 'package:room_manager/model/area.dart';

class AreaService {
  List<Area> areas = [
    Area(id: 1, name: 'Area 1', description: 'Area 1 description'),
    Area(id: 2, name: 'Area 2', description: 'Area 2 description'),
    Area(id: 3, name: 'Area 3', description: 'Area 3 description'),
  ];

  //save area
  Future<void> saveArea(Area area) async {
    return Future.delayed(const Duration(seconds: 2));
  }
}