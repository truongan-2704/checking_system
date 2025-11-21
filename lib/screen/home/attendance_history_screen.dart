import 'package:flutter/material.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  AttendanceHistoryScreen({super.key});

  // Demo dữ liệu - sau này bạn thay bằng API / DB
  final List<Map<String, dynamic>> history = [
    {
      "date": "20/11/2025",
      "class": "10A1",
      "present": 40,
      "total": 45,
      "absent": 5,
      "time": "07:10",
    },
    {
      "date": "19/11/2025",
      "class": "10A1",
      "present": 43,
      "total": 45,
      "absent": 2,
      "time": "07:12",
    },
    {
      "date": "18/11/2025",
      "class": "10A1",
      "present": 45,
      "total": 45,
      "absent": 0,
      "time": "07:08",
    },
    {
      "date": "17/11/2025",
      "class": "10A1",
      "present": 39,
      "total": 45,
      "absent": 6,
      "time": "07:15",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử điểm danh"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = history[index];
          return _buildHistoryCard(
            context,
            date: item["date"],
            className: item["class"],
            present: item["present"],
            total: item["total"],
            absent: item["absent"],
            time: item["time"],
            onTap: () {
              // TODO: sau này có thể mở màn chi tiết ngày đó
              // Navigator.push(...);
            },
          );
        },
      ),
    );
  }

  Widget _buildHistoryCard(
      BuildContext context, {
        required String date,
        required String className,
        required int present,
        required int total,
        required int absent,
        required String time,
        VoidCallback? onTap,
      }) {
    final double rate = total == 0 ? 0 : present * 100 / total;

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
              // Cột ngày
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 18, color: Colors.blue),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Nội dung chính
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lớp $className",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Có mặt: $present/$total  •  Vắng: $absent",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tỷ lệ chuyên cần: ${rate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: rate >= 95
                            ? Colors.green
                            : (rate >= 85 ? Colors.orange : Colors.red),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Điểm danh lúc: $time",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
