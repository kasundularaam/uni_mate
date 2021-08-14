import 'dart:convert';

ResponseUser responseUserFromJson(String str) =>
    ResponseUser.fromJson(json.decode(str));

String responseUserToJson(ResponseUser data) => json.encode(data.toJson());

class ResponseUser {
  bool success;
  String id;
  String name;
  String degree;
  String batch;
  ResponseUser({
    required this.success,
    required this.id,
    required this.name,
    required this.degree,
    required this.batch,
  });

  factory ResponseUser.fromJson(Map<String, dynamic> json) => ResponseUser(
        success: json["success"],
        id: json["id"],
        name: json["name"],
        degree: json["degree"],
        batch: json["batch"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "id": id,
        "name": name,
        "degree": degree,
        "batch": batch,
      };
}
