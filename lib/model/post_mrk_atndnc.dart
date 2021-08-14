import 'dart:convert';

PostMrkAtndnc postMrkAtndncFromJson(String str) =>
    PostMrkAtndnc.fromJson(json.decode(str));

String postMrkAtndncToJson(PostMrkAtndnc data) => json.encode(data.toJson());

class PostMrkAtndnc {
  String longitude;
  String latitude;
  String user;
  String schedule;
  PostMrkAtndnc({
    required this.longitude,
    required this.latitude,
    required this.user,
    required this.schedule,
  });

  factory PostMrkAtndnc.fromJson(Map<String, dynamic> json) => PostMrkAtndnc(
        longitude: json["longitude"],
        latitude: json["latitude"],
        user: json["user"],
        schedule: json["schedule"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "user": user,
        "schedule": schedule,
      };
}
