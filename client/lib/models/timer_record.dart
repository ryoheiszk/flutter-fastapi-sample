import 'package:intl/intl.dart';

class TimerRecord {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final double duration;

  TimerRecord({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  factory TimerRecord.fromJson(Map<String, dynamic> json) {
    return TimerRecord(
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      duration: json['duration'].toDouble(),
    );
  }

  String get formattedDuration {
    final minutes = (duration / 60).floor();
    final seconds = (duration % 60).floor();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedStartTime {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime);
  }
}
