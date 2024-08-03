import 'package:flutter/material.dart';
import 'dart:async';
import 'package:timer_app/services/api_service.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final ApiService _apiService = ApiService();
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  DateTime? _startTime;

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _startTime = DateTime.now();
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() async {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    if (_startTime != null) {
      await _apiService.createTimerRecord(_startTime!, DateTime.now());
    }
    setState(() {
      _seconds = 0;
      _startTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${(_seconds / 60).floor()}:${(_seconds % 60).toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 48),
        ),
        ElevatedButton(
          onPressed: _isRunning ? _stopTimer : _startTimer,
          child: Text(_isRunning ? 'Stop' : 'Start'),
        ),
      ],
    );
  }
}
