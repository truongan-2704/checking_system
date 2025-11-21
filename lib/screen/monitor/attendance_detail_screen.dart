import 'package:flutter/material.dart';

class AttendanceDetailScreen extends StatefulWidget {
  const AttendanceDetailScreen({super.key});

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  // Demo data – sau này bạn thay bằng data từ API
  final List<Map<String, dynamic>> students = [
    {"name": "Nguyễn An",      "status": "present"},
    {"name": "Trần Bình",      "status": "present"},
    {"name": "Lê Cẩm",         "status": "late"},
    {"name": "Phạm Dung",      "status": "absent"},
    {"name": "Hoàng Em",       "status": "excused"},
    {"name": "Võ Gia",         "status": "present"},
    {"name": "Đỗ Hà",          "status": "present"},
    {"name": "Ngô Khang",      "status": "absent"},
  ];

  String filter = "all"; // all / present / absent / late / excused

  @override
  Widget build(BuildContext context) {
    final filtered = students.where((s) {
      if (filter == "all") return true;
      return s["status"] == filter;
    }).toList();

    final total    = students.length;
    final present  = students.where((s) => s["status"] == "present").length;
    final absent   = students.where((s) => s["status"] == "absent").length;
    final late     = students.where((s) => s["status"] == "late").length;
    final excused  = students.where((s) => s["status"] == "excused").length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết điểm danh hôm nay"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tóm tắt nhanh
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200, // 🔥 cả 2 ô sẽ có chiều cao bằng nhau
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
                            const Text(
                              "Tổng quan",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text("Tổng sĩ số: $total học sinh"),
                            Text("Có mặt: $present"),
                            Text("Vắng: $absent"),
                            Text("Đi muộn: $late"),
                            Text("Nghỉ có phép: $excused"),
                            const Spacer(), // 🔥 đẩy dòng cập nhật xuống cuối
                            const Text(
                              "Cập nhật lúc 07:35",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: SizedBox(
                    height: 180, // 🔥 match height với ô Tổng quan
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/images/test.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Thanh filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip("Tất cả", "all"),
                _buildFilterChip("Có mặt", "present"),
                _buildFilterChip("Vắng", "absent"),
                _buildFilterChip("Đi muộn", "late"),
                _buildFilterChip("Có phép", "excused"),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Danh sách chi tiết
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final s = filtered[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _statusColor(s["status"]),
                    child: Text(
                      s["name"].toString()[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(s["name"]),
                  subtitle: Text(_statusText(s["status"])),
                  trailing: Icon(
                    _statusIcon(s["status"]),
                    color: _statusColor(s["status"]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Chip filter
  Widget _buildFilterChip(String label, String value) {
    final bool selected = filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {
          setState(() {
            filter = value;
          });
        },
      ),
    );
  }

  // Text trạng thái
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

  // Màu trạng thái
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

  // Icon trạng thái
  IconData _statusIcon(String status) {
    switch (status) {
      case "present":
        return Icons.check_circle;
      case "absent":
        return Icons.cancel;
      case "late":
        return Icons.access_time;
      case "excused":
        return Icons.info;
      default:
        return Icons.help_outline;
    }
  }
}
