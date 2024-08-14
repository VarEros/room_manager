class Docent {
  int id;
  String name;

  Docent({
    required this.id, 
    required this.name
  });

    Map<String, dynamic> toJson() => {
    "name": name,
  };


  factory Docent.fromJson(Map<String, dynamic> json) => Docent(
    id: json['id'],
    name: json['name'],
  );

}

class DocentResponse {
  final String message;
  final List<Docent> data;

  DocentResponse({
    required this.message,
    required this.data,
  });

factory DocentResponse.fromJson(Map<String, dynamic> json) => DocentResponse(
  message: json['message'] ?? '', // Use empty string if message is null
  data: List<Docent>.from(
    json['data']?.map((docent) => Docent.fromJson(docent)) ?? const [], // Use empty list if data is null
  ),
);
}


