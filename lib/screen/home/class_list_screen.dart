import 'package:flutter/material.dart';

import 'class_detail_screen.dart';

class ClassListScreen extends StatelessWidget {
  ClassListScreen({super.key});

  // Demo data – sau này bạn thay bằng dữ liệu từ API / DB
  final List<Map<String, dynamic>> classList = [
    {
      "name": "10A1",
      "teacher": "Nguyễn Văn A",
      "students": 45,
      "status": "Đang học",
    },
    {
      "name": "10A2",
      "teacher": "Trần Thị B",
      "students": 43,
      "status": "Đang học",
    },
    {
      "name": "11A1",
      "teacher": "Lê Văn C",
      "students": 40,
      "status": "Nghỉ tiết 4",
    },
    {
      "name": "12A3",
      "teacher": "Phạm Thị D",
      "students": 42,
      "status": "Đang học",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách lớp"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: classList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = classList[index];
          return _buildClassCard(
            context,
            name: item["name"],
            teacher: item["teacher"],
            students: item["students"],
            status: item["status"],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClassDetailScreen(
                    className: item["name"],
                    teacher: item["teacher"],
                    students: [
                      {"name": "Nguyễn A", "status": "present"},
                      {"name": "Trần B", "status": "absent"},
                      {"name": "Lê C", "status": "late"},
                      {"name": "Phạm D", "status": "present"},
                      {"name": "Đỗ E", "status": "excused"},
                    ], // TODO: sau này load từ API theo lớp
                  ),
                ),
              );
            },

          );
        },
      ),
    );
  }

  Widget _buildClassCard(
      BuildContext context, {
        required String name,
        required String teacher,
        required int students,
        required String status,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Avatar lớp
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Nội dung
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lớp $name",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "GVCN: $teacher",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Sĩ số: $students học sinh",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Trạng thái + icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: status.contains("nghỉ") || status.contains("Nghỉ")
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
