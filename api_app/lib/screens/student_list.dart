import 'package:api_app/api/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:api_app/models/student.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final api_service = ApiService();
  late final Future<List<Student>> futureStudent;

  @override
  void initState() {
    super.initState();

    getStudents();
  }

  void getStudents() {
    setState(() {
      futureStudent = api_service.fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Student List', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.orange,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white,),
            backgroundColor: Colors.orange,
            onPressed: () {
              // showDialog(context: context, builder: const Placeholder());
            }),
        
      );
}
