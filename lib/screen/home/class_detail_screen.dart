import 'package:flutter/material.dart';

class ClassDetailScreen extends StatelessWidget {
  final String className;
  final String teacher;
  final List<Map<String, dynamic>> students;

  const ClassDetailScreen({
    super.key,
    required this.className,
    required this.teacher,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    final total = students.length;
    final present = students.where((s) => s["status"] == "present").length;
    final absent = students.where((s) => s["status"] == "absent").length;
    final late = students.where((s) => s["status"] == "late").length;
    final excused = students.where((s) => s["status"] == "excused").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lớp $className"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔷 Thẻ tổng quan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("GVCN: $teacher",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text("Sĩ số: $total"),
                    Text("Có mặt: $present"),
                    Text("Vắng: $absent"),
                    Text("Đi muộn: $late"),
                    Text("Có phép: $excused"),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // 🔷 Danh sách học sinh
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: students.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final s = students[index];
                return _buildStudentItem(
                  name: s["name"],
                  status: s["status"],
                  onTap: () {
                    // TODO: mở lịch sử học sinh (sau này muốn thêm)
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentItem({
    required String name,
    required String status,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 22,
                backgroundColor: _statusColor(status).withOpacity(0.15),
                child: Text(
                  name[0], // chữ cái đầu
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _statusColor(status),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _statusText(status),
                      style: TextStyle(
                        fontSize: 13,
                        color: _statusColor(status),
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right,
                color: Colors.grey[500],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _statusText(String status) {
    switch (status) {
      case "present":
        return "Có mặt";
      case "absent":
        return "Vắng";
      case "late":
        return "Đi muộn";
      case "excused":
        return "Nghỉ có phép";
      default:
        return "Không rõ";
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case "present":
        return Colors.green;
      case "absent":
        return Colors.red;
      case "late":
        return Colors.orange;
      case "excused":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
