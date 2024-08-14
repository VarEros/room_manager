import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:room_manager/constants/http.constant.dart';
import 'package:room_manager/model/event.dart';
import 'package:room_manager/model/room.dart';

class EventController{

  Future<http.Response> saveEvent(dynamic json) async {

    print(json);

    try {
      final response = await http.post(
        Uri.parse(Constants.GET_CREATE_EVENT),
        headers: {"Content-Type": "application/json"},
        body: json,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('No se pudo guardar los eventos. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error intentando guardar los eventos: $error');
    }
  }


    Future<EventResponse> getRoomsById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.GET_CREATE_EVENT}/$id}'),
        headers: {"Content-Type": "application/json"}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        print(EventResponse.fromJson(data));

        return EventResponse.fromJson(data);
      } else {
        throw Exception('No se pudo obtener las areas. Status code: ${response.statusCode}');
      }
    } catch (error) {
      
    throw Exception('Error intentando obtener las areas: $error');
    }
  }

}
