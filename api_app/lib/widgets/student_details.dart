// TODO Use the get student by id and display the data

import 'package:api_app/database/students_db.dart';
import 'package:api_app/models/student.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  final Student? student;

  const StudentDetails({Key? key, this.student})
      : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Future<List<Student>>? studentItem;
  final studentDB = StudentsDB();

  @override
  void initState() {
    super.initState();
  }

  void getStudent(int id) {
    setState(() {
      studentItem = studentDB.fetchById(id) as Future<List<Student>>?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Student Details."),
      content: Column(
        children: [
          Text(widget.student!.firstName),
          Text(widget.student!.lastName),
          Text(widget.student!.course),
          Text(widget.student!.year),
          Text(widget.student!.enrolled.toString()),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("Close"))
      ],
    );
  }
}
