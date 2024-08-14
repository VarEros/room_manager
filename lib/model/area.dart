import 'package:flutter/foundation.dart';

class Area {
  int id;
  String name;
  String description = '';

  Area({
    required this.id, 
    required this.name,
    this.description = ''
  });  
}

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
  };

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
    );
  }
}