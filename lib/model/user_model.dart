import 'dart:convert';

class User {
  final String userId;
  final String userName;
  final String userEmail;
  User({
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  User copyWith({
    String? userId,
    String? userName,
    String? userEmail,
  }) {
    return User(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(userId: $userId, userName: $userName, userEmail: $userEmail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.userId == userId &&
        other.userName == userName &&
        other.userEmail == userEmail;
  }

  @override
  int get hashCode => userId.hashCode ^ userName.hashCode ^ userEmail.hashCode;
}
