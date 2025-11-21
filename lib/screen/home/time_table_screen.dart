import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  TimetableScreen({super.key});

  // Demo data TKB – sau này bạn có thể lấy từ API / DB
  final Map<String, List<Map<String, String>>> timetable = {
    "Thứ 2": [
      {"time": "07:00 - 07:45", "subject": "Toán", "room": "P201"},
      {"time": "07:55 - 08:40", "subject": "Ngữ văn", "room": "P201"},
      {"time": "08:50 - 09:35", "subject": "Tiếng Anh", "room": "P202"},
      {"time": "09:45 - 10:30", "subject": "Tin học", "room": "P305"},
    ],
    "Thứ 3": [
      {"time": "07:00 - 07:45", "subject": "Vật lý", "room": "P203"},
      {"time": "07:55 - 08:40", "subject": "Hóa học", "room": "P204"},
      {"time": "08:50 - 09:35", "subject": "Lịch sử", "room": "P201"},
    ],
    "Thứ 4": [
      {"time": "07:00 - 07:45", "subject": "Sinh học", "room": "P205"},
      {"time": "07:55 - 08:40", "subject": "Địa lý", "room": "P201"},
      {"time": "08:50 - 09:35", "subject": "GDCD", "room": "P201"},
    ],
    "Thứ 5": [
      {"time": "07:00 - 07:45", "subject": "Toán", "room": "P201"},
      {"time": "07:55 - 08:40", "subject": "Ngữ văn", "room": "P201"},
      {"time": "08:50 - 09:35", "subject": "Thể dục", "room": "Sân"},
    ],
    "Thứ 6": [
      {"time": "07:00 - 07:45", "subject": "Tin học", "room": "P305"},
      {"time": "07:55 - 08:40", "subject": "Tiếng Anh", "room": "P202"},
      {"time": "08:50 - 09:35", "subject": "Âm nhạc", "room": "P101"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final days = timetable.keys.toList();

    return DefaultTabController(
      length: days.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Thời khóa biểu"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: days.map((d) => Tab(text: d)).toList(),
          ),
        ),
        body: TabBarView(
          children: days.map((day) {
            final lessons = timetable[day] ?? [];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: lessons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  return _buildLessonCard(
                    time: lesson["time"] ?? "",
                    subject: lesson["subject"] ?? "",
                    room: lesson["room"] ?? "",
                    index: index + 1,
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Card 1 tiết học
  Widget _buildLessonCard({
    required String time,
    required String subject,
    required String room,
    required int index,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Cột số tiết
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                "$index",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
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
                    subject,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Phòng: $room",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
