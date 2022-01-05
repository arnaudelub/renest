import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tasks = [
  'Take measurements',
  'Begin packing',
  'Do a change of address',
  'Order supplies',
  'Book Professional movers',
  'Prepare the house',
  'Review moving plan',
  'Prepare for payment',
  'Pack essential box',
  'Prepare appliance',
  'Measure furniture and doorways',
];

enum Priority { high, normal, low }

extension PriorityX on Priority {
  static const options = {
    Priority.high: 'high',
    Priority.low: 'low',
    Priority.normal: 'normal'
  };

  static Priority? fromString(String value) =>
      Priority.values.firstWhere((element) => options[element] == value);
}

class Storage {
  const Storage(this.client);

  final SharedPreferences client;

  Future<void> init() async {
    debugPrint("Init storage");
    try {
      final initValue = client.getString('IsInitiated');
      debugPrint("InitValue is $initValue");
      if (initValue == '0' || initValue == null) {
        debugPrint("Adding tasks");
        for (final String task in tasks) {
          await client.setString(task, 'init');
        }
        await client.setString('IsInitiated', '1');
      }
    } catch (e) {
      debugPrint("Error saving the tasks, $e");
      await client.clear();
    }
  }

  Future<void> addTask(String task, Priority priority) async {
    try {
      await client.setString(task, priority.name);
      final keys = client.getKeys();
      debugPrint("Got keys after adding $keys");
    } catch (e) {
      debugPrint('Error adding task $e');
    }
  }

  Future<void> completeTask(String task) async {
    try {
      //await client.remove(task);
      await client.setString(task, 'completed');
    } catch (e) {
      debugPrint('Error adding task $e');
    }
  }

  Future<List<Map<String, String>>> getAvailableTasks() async {
    /// Get the tasks that are still not assigned
    return _getTaskByType('init');
  }

  Future<List<Map<String, String>>> getCompletedTasks() async {
    /// Get the tasks marked as completed
    return _getTaskByType('completed');
  }

  Future<List<Map<String, String>>> getPrioritizedTasks() async {
    /// Get the tasks marked as completed
    return _getTaskByType(null, prioritized: true);
  }

  Future<List<Map<String, String>>> _getTaskByType(String? type,
      {bool prioritized = false}) async {
    try {
      final List<Map<String, String>> storedData = [];
      final keys = client.getKeys();
      debugPrint("Got keys $keys");
      for (final key in keys) {
        final data = client.getString(key);
        debugPrint("Data is $data");
        if (prioritized && ['high', 'normal', 'low'].contains(data)) {
          if (PriorityX.fromString(data!) != null) {
            storedData.add({key: data});
          }
        } else if (data == type) {
          storedData.add({key: data!});
        }
      }
      return storedData;
    } catch (e) {
      debugPrint("Error getting storage $e");
      // Todo create a custom Error type
      throw UnimplementedError();
    }
  }

  Future<void> clean() async {
    await client.clear();
  }
}
