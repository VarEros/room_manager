import 'package:room_manager/model/docent.dart';

class DocentService {
  List<Docent> docents = [];

  emptyDocent() {
    return Docent(id: 0, name: '');
  }

  Future getDocents() {
    return Future.delayed(const Duration(seconds: 1), () {
      docents = [
        Docent(id: 1, name: 'Docente 1'),
        Docent(id: 2, name: 'Docente 2'),
        Docent(id: 3, name: 'Docente 3'),
      ];
    });
  }

  Future saveDocent(Docent docent) {
    return Future.delayed(const Duration(seconds: 1), () {
      print('Docente guardado');
    });
  }
}