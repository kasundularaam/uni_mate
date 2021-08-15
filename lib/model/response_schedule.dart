import 'dart:convert';

ResponseSchedule responseScheduleFromJson(String str) =>
    ResponseSchedule.fromJson(json.decode(str));

String responseScheduleToJson(ResponseSchedule data) =>
    json.encode(data.toJson());

class ResponseSchedule {
  DateTime date;
  String startTime;
  String endTime;
  String id;
  String name;
  String batch;
  String moduleName;
  ResponseSchedule({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.name,
    required this.batch,
    required this.moduleName,
  });

  factory ResponseSchedule.fromJson(Map<String, dynamic> json) =>
      ResponseSchedule(
        date: DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["id"],
        name: json["name"],
        batch: json["batch"],
        moduleName: json["moduleName"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "id": id,
        "name": name,
        "batch": batch,
        "moduleName": moduleName,
      };
}
