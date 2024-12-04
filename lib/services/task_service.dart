import 'dart:convert';
import 'package:habittracker/services/api_service.dart';

class TaskService {
  final apiService = ApiService();

  Future<List<Task>> getTasks() async {
    try {
      final response = await apiService.get('/tasks');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        
        // Ensure the response contains a 'tasks' key
        final List<dynamic> tasksJson = jsonResponse['data'] ?? [];
        
        // Convert the list of JSON objects into Task instances
        return tasksJson.map((json) => Task.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tasks: ${response.body}');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<Task> createTask(Task task) async {
    try {
      print("TTT"+task.title+ task.description+ task.status+ task.startDate.toIso8601String()+ task.endDate.toIso8601String());

      final response = await apiService.post('/create', {
        'title': task.title,
        'description': task.description,
        'status': task.status,
        'startDate': task.startDate.toIso8601String(),
        'endDate': task.endDate.toIso8601String(),
        'user' :'674f07a4fa257c22c4290009'
      });


      if (response.statusCode == 201) {
        return Task.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create task: ${response.body}');
      }
    } catch (e) {
      print('Error creating task: $e');
      throw Exception('Failed to create task');
    }
  }

 Future<Task> updateTask(Task task) async {
  try {
    final requestBody = {
      'status': task.status,
      // Include any other fields you wish to update, or keep it minimal if updating only status
    };

    final response = await apiService.put('/updatetask/${task.id}', requestBody);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['data'] != null) {
        return Task.fromJson(responseBody['data']); // Access the 'data' field
      } else {
        throw Exception('Failed to parse response data: ${response.body}');
      }
    } else {
      throw Exception('Failed to update task: ${response.body}');
    }
  } catch (e) {
    print('Error updating task: $e');
    throw Exception('Failed to update task');
  }
}


  Future<void> deleteTask(String id) async {
    try {
      final response = await apiService.delete('/tasks/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete task: ${response.body}');
      }
    } catch (e) {
      print('Error deleting task: $e');
      throw Exception('Failed to delete task');
    }
  }

  
}

class Task {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime startDate;
  final DateTime endDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  // Factory constructor to create a Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] ?? '', // Ensure default fallback for null values
      title: json['title'] ?? 'Untitled Task',
      description: json['description'] ?? 'No description',
      status: json['status'] ?? 'Pending',
      startDate: DateTime.parse(json['startDate']), // Parse date strings
      endDate: DateTime.parse(json['endDate']),
    );
  }
}

