import 'dart:convert';

import 'package:room_manager/controllers/docent.controller.dart';
import 'package:room_manager/model/docent.dart';

class DocentService {
  List<Docent> docents = [];

  emptyDocent() {
    return Docent(id: 0, name: '');
  }

  Future<List<Docent>> getDocents() async{
    final roomData = await DocentController().getRooms();
    docents = roomData.data;
    return docents;
  }

  Future<void> saveDocent(Docent docent) async {
    DocentController().saveDocent(json.encode(docent.toJson()));
  }
}
