import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timer_app/models/timer_record.dart';

class ApiService {
  final String baseUrl = '/api'; // ここを確認

  Future<TimerRecord> createTimerRecord(DateTime startTime, DateTime endTime) async {
    final response = await http.post(
      Uri.parse('$baseUrl/timer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'start_time': startTime.toIso8601String(),
        'end_time': endTime.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return TimerRecord.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create timer record: ${response.statusCode}');
    }
  }

  Future<List<TimerRecord>> getAllTimerRecords() async {
    final response = await http.get(Uri.parse('$baseUrl/timer'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => TimerRecord.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load timer records: ${response.statusCode}');
    }
  }

  Future<bool> deleteTimerRecord(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/timer/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete timer record: ${response.statusCode}');
    }
  }
}
