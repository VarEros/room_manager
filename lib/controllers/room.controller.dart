import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:room_manager/constants/http.constant.dart';
import 'package:room_manager/model/room.dart';

class RoomController{
 
 Future<http.Response> saveRoom(dynamic json) async {

  try {
    final response = await http.post(
      Uri.parse(Constants.GET_CREATE_ROOM),
      headers: {"Content-Type": "application/json"},
      body: json,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('No se pudo guardar la sala. Status code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error intentando guardar la sala: $error');
  }
 }



    Future<RoomResponse> getRoomsByAreaId(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.GET_CREATE_ROOM}/$id'),
        headers: {"Content-Type": "application/json"}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return RoomResponse.fromJson(data);
      } else {
        throw Exception('No se pudo obtener las areas. Status code: ${response.statusCode}');
      }
    } catch (error) {
      
    throw Exception('Error intentando obtener las areas: $error');
    }
  }



  Future<RoomResponse> getRooms() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.GET_CREATE_ROOM),
        headers: {"Content-Type": "application/json"}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return RoomResponse.fromJson(data);
      } else {
        throw Exception('No se pudo obtener las areas. Status code: ${response.statusCode}');
      }
    } catch (error) {
      
    throw Exception('Error intentando obtener las areas: $error');
    }
  }
}
