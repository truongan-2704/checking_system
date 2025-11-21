import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<Map<String, dynamic>> reportData = [
    {"date": "20/11/2025", "present": 40, "total": 45},
    {"date": "19/11/2025", "present": 43, "total": 45},
    {"date": "18/11/2025", "present": 45, "total": 45},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Báo cáo chuyên cần"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: exportPDF,
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final item = reportData[i];
          return Card(
            elevation: 2,
            child: ListTile(
              title: Text("Ngày ${item["date"]}"),
              subtitle: Text("Có mặt: ${item["present"]}/${item["total"]}"),
              trailing: Text(
                "${(item["present"] * 100 / item["total"]).toStringAsFixed(1)}%",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: reportData.length,
      ),
    );
  }

  /// 🧾 Xuất PDF
  Future<void> exportPDF() async {
    final pdf = pw.Document();

    // 🔹 Tạo nội dung PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "BÁO CÁO CHUYÊN CẦN",
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text("Lớp: 10A1"),
              pw.Text("Giáo viên chủ nhiệm: Nguyễn Văn A"),
              pw.Divider(),
              pw.Table.fromTextArray(
                headers: ["Ngày", "Có mặt", "Tổng", "%"],
                data: reportData.map((item) {
                  final rate = item["present"] * 100 / item["total"];
                  return [
                    item["date"],
                    item["present"].toString(),
                    item["total"].toString(),
                    "${rate.toStringAsFixed(1)}%",
                  ];
                }).toList(),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Smart Muster Camera - 2025 ©",
                style: pw.TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );

    // 🔹 Lưu file vào bộ nhớ máy (thư mục documents của app)
    try {
      final bytes = await pdf.save();

      // Lấy thư mục lưu trữ nội bộ của app
      final dir = await getApplicationDocumentsDirectory();
      final String filePath =
          "${dir.path}/bao_cao_chuyen_can_10A1_${DateTime.now().millisecondsSinceEpoch}.pdf";

      final file = File(filePath);
      await file.writeAsBytes(bytes);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Đã lưu file PDF tại:\n$filePath"),
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lỗi khi lưu PDF: $e"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

}
