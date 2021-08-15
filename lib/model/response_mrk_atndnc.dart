import 'dart:convert';

ResponseMrkAtndnc responseMrkAtndncFromJson(String str) =>
    ResponseMrkAtndnc.fromJson(json.decode(str));

String responseMrkAtndncToJson(ResponseMrkAtndnc data) =>
    json.encode(data.toJson());

class ResponseMrkAtndnc {
  bool success;
  ResponseMrkAtndnc({
    required this.success,
  });

  factory ResponseMrkAtndnc.fromJson(Map<String, dynamic> json) =>
      ResponseMrkAtndnc(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
