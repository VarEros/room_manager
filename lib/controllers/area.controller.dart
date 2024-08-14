import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:room_manager/constants/http.constant.dart';
import 'package:room_manager/model/area.dart';

class AreaController{
 
 Future<http.Response> saveArea(dynamic json) async {
  try {
    final response = await http.post(
      Uri.parse(Constants.GET_CREATE_AREAS),
      headers: {"Content-Type": "application/json"},
      body: json,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('No se pudo guardar el area. Status code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error intentando guardar el area: $error');
  }
 }


   Future<http.Response> updateArea(int id, dynamic json) async {
  try {
    final response = await http.put(
      Uri.parse('${Constants.GET_CREATE_AREAS}/$id'),
      headers: {"Content-Type": "application/json"},
      body: json,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('No se pudo guardar el area. Status code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error intentando guardar el area: $error');
  }
 }


  Future<List<Area>> getAreas() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.GET_CREATE_AREAS),
        headers: {"Content-Type": "application/json"}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decodifica la respuesta JSON obtenida desde nuestro backend
        List<dynamic> body = json.decode(response.body)['areas'];
        
        // Convierte cada elemento en un objeto Area
        List<Area> areas = body.map((dynamic item) => Area.fromJson(item)).toList();
        
        return areas;
      } else {
        throw Exception('No se pudo obtener las areas. Status code: ${response.statusCode}');
      }
    } catch (error) {
      
    throw Exception('Error intentando obtener las areas: $error');
    }
  }
}
