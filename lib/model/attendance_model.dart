class AttendanceModel {
  final String id;
  final int total;
  final int present;
  final List<String> absent;
  final String image;
  final DateTime createdAt;

  AttendanceModel({
    required this.id,
    required this.total,
    required this.present,
    required this.absent,
    required this.image,
    required this.createdAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json["_id"] ?? "",
      total: json["total"] ?? 0,
      present: json["present"] ?? 0,
      absent: List<String>.from(json["absent"] ?? []),
      image: json["image"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
