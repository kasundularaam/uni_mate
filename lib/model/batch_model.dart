import 'dart:convert';

class BatchModel {
  final String batchId;
  final String batchName;
  BatchModel({
    required this.batchId,
    required this.batchName,
  });

  BatchModel copyWith({
    String? batchId,
    String? batchName,
  }) {
    return BatchModel(
      batchId: batchId ?? this.batchId,
      batchName: batchName ?? this.batchName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'batchId': batchId,
      'batchName': batchName,
    };
  }

  factory BatchModel.fromMap(Map<String, dynamic> map) {
    return BatchModel(
      batchId: map['batchId'],
      batchName: map['batchName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BatchModel.fromJson(String source) =>
      BatchModel.fromMap(json.decode(source));

  @override
  String toString() => 'BatchModel(batchId: $batchId, batchName: $batchName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BatchModel &&
        other.batchId == batchId &&
        other.batchName == batchName;
  }

  @override
  int get hashCode => batchId.hashCode ^ batchName.hashCode;
}
