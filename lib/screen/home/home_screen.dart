import 'package:checking_system/screen/home/time_table_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Map<String, dynamic>> features = [
    {"icon": Icons.camera_alt, "label": "Điểm danh"},
    {"icon": Icons.people, "label": "Danh sách lớp"},
    {"icon": Icons.history, "label": "Lịch sử"},
    {"icon": Icons.notifications, "label": "Thông báo"},
    {"icon": Icons.chat, "label": "Chat GV"},
    {"icon": Icons.calendar_month, "label": "T.khoá biểu"},
    {"icon": Icons.picture_as_pdf, "label": "Báo cáo"},
    {"icon": Icons.settings, "label": "Cài đặt"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        slideshow_widget(),
        const SizedBox(height: 16),
        title_widget(),
        const SizedBox(height: 12),
        menuGrid_widget(),   // 🔥 lưới chức năng dạng ngân hàng
      ],
    );
  }

  Widget slideshow_widget() {
    final List<String> imgList = [
      "assets/images/hinh1.jfif",
      "assets/images/hinh1.jfif",
      "assets/images/hinh1.jfif",
    ];
    return CarouselSlider(
      items: imgList.map((item) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          item,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      )).toList(),
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 900),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
    );
  }

  Widget title_widget() {
    return const Text(
      'Các chức năng',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  /// 🔥 Lưới nút chức năng dạng ngân hàng
  Widget menuGrid_widget() {
    return GridView.builder(
      itemCount: features.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,       // 4 ô / hàng
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = features[index];
        return InkWell(
          onTap: () {
            switch (item["label"]) {
              case "T.khoá biểu":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TimetableScreen()),
                );
                break;

            // Bạn muốn mở màn nào cho các button khác thì thêm case tương ứng
              default:
                debugPrint("Click: ${item["label"]}");
            }
          },

          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(item["icon"], size: 24, color: Colors.blue),
              ),
              const SizedBox(height: 6),
              Text(
                item["label"],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
