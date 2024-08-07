import 'package:room_manager/model/area.dart';

class User {
  String email;
  Area? area;

  User({
    required this.email,
    this.area
  });
}