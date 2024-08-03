import 'package:flutter/material.dart';
import 'package:timer_app/models/timer_record.dart';
import 'package:timer_app/services/api_service.dart';
import 'package:timer_app/widgets/history_list_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ApiService _apiService = ApiService();
  List<TimerRecord> _records = [];
  bool _isLoading = true;

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
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading records: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load timer records')),
      );
    }
  }

  Future<void> _deleteRecord(String id) async {
    try {
      final success = await _apiService.deleteTimerRecord(id);
      if (success) {
        setState(() {
          _records.removeWhere((record) => record.id == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Record deleted successfully')),
        );
      }
    } catch (e) {
      print('Error deleting record: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete record')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer History'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _records.isEmpty
              ? Center(child: Text('No timer records found'))
              : ListView.builder(
                  itemCount: _records.length,
                  itemBuilder: (context, index) {
                    final record = _records[index];
                    return ListTile(
                      title: Text('Duration: ${record.formattedDuration}'),
                      subtitle: Text('Started: ${record.formattedStartTime}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteRecord(record.id),
                      ),
                      onTap: () {
                        // TODO: Implement record details view
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Record details coming soon')),
                        );
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadRecords,
        child: Icon(Icons.refresh),
        tooltip: 'Refresh Records',
      ),
    );
  }
}
