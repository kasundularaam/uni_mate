import 'dart:convert';

class UserData {
  final String userId;
  final String userName;
  final String batchId;
  final String degreeId;
  UserData({
    required this.userId,
    required this.userName,
    required this.batchId,
    required this.degreeId,
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
      batchId: batchId ?? this.batchId,
      degreeId: degreeId ?? this.degreeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'batchId': batchId,
      'degreeId': degreeId,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      userId: map['userId'],
      userName: map['userName'],
      batchId: map['batchId'],
      degreeId: map['degreeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(userId: $userId, userName: $userName, batchId: $batchId, degreeId: $degreeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.userId == userId &&
        other.userName == userName &&
        other.batchId == batchId &&
        other.degreeId == degreeId;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        batchId.hashCode ^
        degreeId.hashCode;
  }
}
