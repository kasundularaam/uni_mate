import 'dart:convert';

ResponseAuthS responseAuthSFromJson(String str) =>
    ResponseAuthS.fromJson(json.decode(str));

String responseAuthSToJson(ResponseAuthS data) => json.encode(data.toJson());

class ResponseAuthS {
  bool success;
  ResponseAuthS({
    required this.success,
  });

  factory ResponseAuthS.fromJson(Map<String, dynamic> json) => ResponseAuthS(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
