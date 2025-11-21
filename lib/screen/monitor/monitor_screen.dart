import 'package:checking_system/screen/monitor/widget/card_monitor.dart'; // InfoCard
import 'package:flutter/material.dart';

import 'attendance_detail_screen.dart';
// import 'package:carousel_slider/carousel_slider.dart'; // nếu chưa dùng thì có thể comment

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({super.key});

  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          listClassWidget(),
        ],
      ),
    );
  }

  Widget listClassWidget() {
    return InfoCard(
      title: "Điểm danh hôm nay",
      image: "assets/images/test.jpg",
      description: "Số lượng có mặt: 26/30 — cập nhật lúc 07:35",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AttendanceDetailScreen(),
          ),
        );
      },
    );
  }
}
