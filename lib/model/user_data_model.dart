import 'dart:convert';

class UserData {
  final String userId;
  final String userName;
  final String batch;
  final String degree;
  UserData({
    required this.userId,
    required this.userName,
    required this.batch,
    required this.degree,
  });

  UserData copyWith({
    String? userId,
    String? userName,
    String? batchId,
    String? degreeId,
  }) {
    return UserData(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      batch: batchId ?? this.batch,
      degree: degreeId ?? this.degree,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'batchId': batch,
      'degreeId': degree,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      userId: map['userId'],
      userName: map['userName'],
      batch: map['batchId'],
      degree: map['degreeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(userId: $userId, userName: $userName, batchId: $batch, degreeId: $degree)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.userId == userId &&
        other.userName == userName &&
        other.batch == batch &&
        other.degree == degree;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        batch.hashCode ^
        degree.hashCode;
  }
}
