import 'package:flutter/material.dart';
import 'package:api_app/widgets/student_list_item.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue, title: const Text("Data pls work")),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: StudentListItems(),
      ),
    );
  }
}
