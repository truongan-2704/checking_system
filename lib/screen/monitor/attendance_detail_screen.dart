import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceDetailScreen extends StatefulWidget {
  const AttendanceDetailScreen({super.key});

  @override
  State<AttendanceDetailScreen> createState() =>
      _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  List<Map<String, dynamic>> students = [];
  String filter = "all";
  bool loading = true;

  int total = 0;
  int present = 0;
  int absent = 0;
  int late = 0;
  int excused = 0;

  String updatedAt = "";
  String attendanceImage = "";

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    setState(() => loading = true);

    try {
      final url = Uri.parse(
        "https://project-nodejs-1-feg9.onrender.com/api/attendance/last",
      );
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final result = data["result"];

        total = result["total"];
        present = result["present"];
        absent = result["absent"].length;
        late = 0;
        excused = 0;

        // Convert UTC → Vietnam time (+7)
        final rawTime = DateTime.parse(result["createdAt"]);
        final vnTime = rawTime.add(const Duration(hours: 7));

        // Format: HH:mm – DD/MM/YYYY
        final hour = vnTime.hour.toString().padLeft(2, '0');
        final minute = vnTime.minute.toString().padLeft(2, '0');

        final day = vnTime.day.toString().padLeft(2, '0');
        final month = vnTime.month.toString().padLeft(2, '0');
        final year = vnTime.year;

        updatedAt = "$hour:$minute – $day/$month/$year";

        attendanceImage = result["image"];

        students = [
          ...result["absent"].map<Map<String, dynamic>>(
                (name) => {
              "name": name,
              "status": "absent",
            },
          ),
        ];
      }
    } catch (e) {
      print("ERROR: $e");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = students.where((s) {
      if (filter == "all") return true;
      return s["status"] == filter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết điểm danh hôm nay"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchAttendance,
          ),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // 🔵 OVERVIEW + IMAGE (Responsive)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📌 LEFT — Overview Card
                Expanded(
                  flex: 6,
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
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text("Tổng sĩ số: $total"),
                          Text("Có mặt: $present"),
                          Text("Vắng: $absent"),
                          Text("Đi muộn: $late"),
                          Text("Có phép: $excused"),
                          const SizedBox(height: 10),
                          Text(
                            "Cập nhật: $updatedAt",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // 📌 RIGHT — Attendance Image
                Expanded(
                  flex: 4,
                  child: AspectRatio(
                    aspectRatio: 1, // hình vuông tự chia tỷ lệ
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: attendanceImage.isNotEmpty
                          ? Image.network(
                        "https://project-nodejs-1-feg9.onrender.com$attendanceImage",
                        fit: BoxFit.cover,
                      )
                          : Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Text("Không có ảnh"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔵 FILTER CHIPS
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

          // 🔵 STUDENT LIST
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
                      s["name"][0],
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
          )
        ],
      ),
    );
  }

  // 🔵 Filter chip widget
  Widget _buildFilterChip(String label, String value) {
    final bool selected = filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {
          setState(() => filter = value);
        },
      ),
    );
  }

  // 🔵 Status Text Mapping
  String _statusText(String status) {
    switch (status) {
      case "present":
        return "Có mặt";
      case "absent":
        return "Vắng";
      case "late":
        return "Đi muộn";
      case "excused":
        return "Có phép";
      default:
        return "Không rõ";
    }
  }

  // 🔵 Status Colors
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

  // 🔵 Status Icons
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
