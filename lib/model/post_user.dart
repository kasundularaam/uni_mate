import 'dart:convert';

PostUser postUserFromJson(String str) => PostUser.fromJson(json.decode(str));

String postUserToJson(PostUser data) => json.encode(data.toJson());

class PostUser {
  String userName;
  String password;
  PostUser({
    required this.userName,
    required this.password,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
        userName: json["userName"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
      };
}
