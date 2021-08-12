import 'dart:convert';

class Lecture {
  final String lectureId;
  final String lectureName;
  final String lecturerName;
  final int lectureTime;
  Lecture({
    required this.lectureId,
    required this.lectureName,
    required this.lecturerName,
    required this.lectureTime,
  });

  Lecture copyWith({
    String? lectureId,
    String? lectureName,
    String? lecturerName,
    int? lectureTime,
  }) {
    return Lecture(
      lectureId: lectureId ?? this.lectureId,
      lectureName: lectureName ?? this.lectureName,
      lecturerName: lecturerName ?? this.lecturerName,
      lectureTime: lectureTime ?? this.lectureTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lectureId': lectureId,
      'lectureName': lectureName,
      'lecturerName': lecturerName,
      'lectureTime': lectureTime,
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      lectureId: map['lectureId'],
      lectureName: map['lectureName'],
      lecturerName: map['lecturerName'],
      lectureTime: map['lectureTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecture.fromJson(String source) =>
      Lecture.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lecture(lectureId: $lectureId, lectureName: $lectureName, lecturerName: $lecturerName, lectureTime: $lectureTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lecture &&
        other.lectureId == lectureId &&
        other.lectureName == lectureName &&
        other.lecturerName == lecturerName &&
        other.lectureTime == lectureTime;
  }

  @override
  int get hashCode {
    return lectureId.hashCode ^
        lectureName.hashCode ^
        lecturerName.hashCode ^
        lectureTime.hashCode;
  }
}
