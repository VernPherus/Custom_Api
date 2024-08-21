//TODO: CREATE A DIFFERENT PAGE FOR MAKING NEW RECORDS
//TODO: CREATE A PAGE FOR VIEWING, UPDATING AND DELETING RECORD

import 'package:api_app/database/students_db.dart';
import 'package:api_app/models/student.dart';
import 'package:api_app/widgets/student_widget.dart';
import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  Future<List<Student>>? futureStudents;
  final studentDB = StudentsDB();

  @override
  void initState() {
    super.initState();

    fetchStudents();
  }

  void fetchStudents() {
    setState(() {
      futureStudents = StudentsDB().fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Student List"),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {
              showDialog(context: context, builder: (_) => StudentWidget());
            }),
      );
}
