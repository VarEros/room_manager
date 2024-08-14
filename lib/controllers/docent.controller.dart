import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:room_manager/constants/http.constant.dart';
import 'package:room_manager/model/docent.dart';

class DocentController {
  Future<http.Response> saveDocent(dynamic json) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.GET_CREATE_DOCENT),
        headers: {"Content-Type": "application/json"},
        body: json,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('No se pudo guardar el docente. Status code: ${response.statusCode}');
    }
    } catch (error) {
      throw Exception('Error intentando guardar el docente: $error');
    }
  }
Future<DocentResponse> getRooms() async {
  try {
    final response = await http.get(
      Uri.parse(Constants.GET_CREATE_DOCENT),
      headers: {"Content-Type": "application/json"}
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return DocentResponse.fromJson(data);
    } else {
      throw Exception('No se pudieron obtener los docentes. Status code: ${response.statusCode}');
    }
  } catch (error) {
    
  throw Exception('Error intentando obtener los docentes: $error');
  }
}

}
