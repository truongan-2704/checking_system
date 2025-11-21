import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  // 🔹 Data thông báo gộp luôn ở đây (ko cần model riêng)
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Điểm danh hôm nay",
      "message": "đã cập nhật: 26/30 học sinh có mặt.",
      "time": "5 phút trước",
      "avatar": "assets/images/test.jpg",
      "isRead": false,
    },
    {
      "title": "Bạn A",
      "message": "vắng có phép ngày 20/11.",
      "time": "30 phút trước",
      "avatar": null,
      "isRead": false,
    },
    {
      "title": "Hệ thống",
      "message": "đã đồng bộ dữ liệu điểm danh với server.",
      "time": "1 giờ trước",
      "avatar": null,
      "isRead": true,
    },
    {
      "title": "Giáo viên chủ nhiệm",
      "message": "gửi ghi chú về tình hình học tập.",
      "time": "Hôm qua",
      "avatar": null,
      "isRead": true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final noti = notifications[index];
          return buildNotificationItem(
            title: noti["title"],
            message: noti["message"],
            time: noti["time"],
            avatar: noti["avatar"],
            isRead: noti["isRead"],
            onTap: () {
              // TODO: xử lý khi click
            },
          );
        },
      ),
    );
  }

  /// 🔥 Widget thông báo giống Facebook, gộp model vào tham số luôn
  Widget buildNotificationItem({
    required String title,
    required String message,
    required String time,
    String? avatar,
    bool isRead = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: isRead ? Colors.white : const Color(0xFFE3F2FD), // chưa đọc nền xanh nhạt
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: 22,
              backgroundImage: avatar != null ? AssetImage(avatar) : null,
              backgroundColor: avatar == null ? Colors.blue : null,
              child: avatar == null
                  ? const Icon(Icons.notifications, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),

            // Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black87, fontSize: 14),
                      children: [
                        TextSpan(
                          text: title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: " "),
                        TextSpan(text: message),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Chấm xanh chưa đọc
            if (!isRead)
              Container(
                margin: const EdgeInsets.only(left: 4, top: 6),
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
