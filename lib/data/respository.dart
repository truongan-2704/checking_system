
import '../model/attendance_model.dart';
import '../service/attendance_service.dart';

class AttendanceRepository {
  Future<AttendanceModel?> getLastAttendance() async {
    final raw = await AttendanceService.fetchLastAttendance();

    if (raw == null) return null;

    return AttendanceModel.fromJson(raw);
  }
}
