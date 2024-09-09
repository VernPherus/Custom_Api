import 'package:api_app/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://api-students.vercel.app';

  Future<List<Student>> fetchStudents() async {
    final url = Uri.parse('$baseUrl/students');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> studentJson = json.decode(response.body)['data'];
        return studentJson.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get student data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Student> getStudentById(String id) async {
    final url = Uri.parse('$baseUrl/student/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load student');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> createStudent(
      {required String fname,
      required String lname,
      required String course,
      required String year,
      required bool enrolled}) async {
    final url = Uri.parse('$baseUrl/student/create');
    try {
      final response = await http.post(url,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({
            'fname': fname,
            'lname': lname,
            'course': course,
            'year': year,
            'enrolled': enrolled
          }));

      if (response.statusCode == 200) {
        print("Succesfully created");
        print(response.body);
      } else {
        throw Exception('Failed to created');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> updateStudent(
      {required String id,
      required String fname,
      required String lname,
      required String course,
      required String year,
      required bool enrolled}) async {
    final url = Uri.parse('$baseUrl/student/update/$id');
    try {
      final response = await http.put(url,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({
            'fname': fname,
            'lname': lname,
            'course': course,
            'year': year,
            'enrolled': enrolled
          }));

      if (response.statusCode == 200) {
        print('Student updated successfully');
      } else {
        throw Exception('Failed to update student');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteStudent(String id) async {
    final url = Uri.parse('$baseUrl/student/delete/$id');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Student deleted successfully');
      } else {
        throw Exception('Failed to delete student');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
