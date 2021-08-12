import 'dart:convert';

class Degree {
  final String degreeId;
  final String degreeName;
  Degree({
    required this.degreeId,
    required this.degreeName,
  });

  Degree copyWith({
    String? degreeId,
    String? degreeName,
  }) {
    return Degree(
      degreeId: degreeId ?? this.degreeId,
      degreeName: degreeName ?? this.degreeName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'degreeId': degreeId,
      'degreeName': degreeName,
    };
  }

  factory Degree.fromMap(Map<String, dynamic> map) {
    return Degree(
      degreeId: map['degreeId'],
      degreeName: map['degreeName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Degree.fromJson(String source) => Degree.fromMap(json.decode(source));

  @override
  String toString() => 'Degree(degreeId: $degreeId, degreeName: $degreeName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Degree &&
        other.degreeId == degreeId &&
        other.degreeName == degreeName;
  }

  @override
  int get hashCode => degreeId.hashCode ^ degreeName.hashCode;
}
