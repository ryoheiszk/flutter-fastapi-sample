import 'package:flutter/material.dart';
import 'package:timer_app/models/timer_record.dart';
import 'package:timer_app/services/api_service.dart';

class HistoryListWidget extends StatefulWidget {
  const HistoryListWidget({Key? key}) : super(key: key);

  @override
  _HistoryListWidgetState createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  final ApiService _apiService = ApiService();
  List<TimerRecord> _records = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    try {
      final records = await _apiService.getAllTimerRecords();
      setState(() {
        _records = records;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print('Error loading records: $e');
    }
  }

  Future<void> _deleteRecord(String id) async {
    try {
      final success = await _apiService.deleteTimerRecord(id);
      if (success) {
        setState(() {
          _records.removeWhere((record) => record.id == id);
        });
      }
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print('Error deleting record: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _records.length,
      itemBuilder: (context, index) {
        final record = _records[index];
        return ListTile(
          title: Text(record.formattedDuration),
          subtitle: Text(record.formattedStartTime),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteRecord(record.id),
          ),
        );
      },
    );
  }
}
