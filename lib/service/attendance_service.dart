import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceService {
  static const String baseUrl = "https://project-nodejs-1-feg9.onrender.com/api";

  static Future<Map<String, dynamic>?> fetchLastAttendance() async {
    final url = Uri.parse("$baseUrl/attendance/last");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["result"];
    }

    return null;
  }
}
