import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_app/models/student.dart';

class StudentListItems extends StatefulWidget {
  const StudentListItems({super.key});

  @override
  State<StudentListItems> createState() => _StudentListItemsState();
}

class _StudentListItemsState extends State<StudentListItems> {
  Future<List<Student>> studentFuture = fetchStudentData();

  static Future<List<Student>> fetchStudentData() async {
    final response =
        await http.get(Uri.parse('https://api-students.vercel.app/students'));
      
    if(response.statusCode == 200){
      List<dynamic> studentJson = json.decode(response.body)['data'];
      return studentJson.map((json)=> Student.fromJson(json)).toList();
    }else{
      throw Exception('Failed to get student Data');
    }
  }

  Widget buildStudents(List<Student> students) => ListView.builder(
    itemCount: students.length,
    itemBuilder: (context, index){
      final student = students[index];

      return Card(
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(student.firstName),
          subtitle: Text('${student.course}, ${student.enrolled}'),
          trailing: const Icon(Icons.drag_handle),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: studentFuture, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: const CircularProgressIndicator());
      }else if(snapshot.hasData){
        final students = snapshot.data!;
        return buildStudents(students);
      }else{
        return Center(child: const Text("No Student Data"));
      }
    });
  }
}
