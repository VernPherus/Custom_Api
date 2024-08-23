// TODO create a different page for creating students
// TODO create another page for updating students

import 'package:api_app/database/students_db.dart';
import 'package:api_app/models/student.dart';
import 'package:api_app/screens/student_form.dart';
import 'package:api_app/widgets/student_create.dart';
import 'package:api_app/widgets/student_details.dart';
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
        body: FutureBuilder<List<Student>>(
            future: futureStudents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final students = snapshot.data!;

                return students.isEmpty
                    ? const Center(
                        child: Text(
                          'No Students.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final student = students[index];
                          final subtitle = student.id.toString();
                          return ListTile(
                            title: Text(
                              student.firstName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(subtitle),
                            trailing: IconButton(
                                onPressed: () async {
                                  await studentDB.delete(student.id);
                                  fetchStudents();
                                },
                                icon: const Icon(Icons.delete,
                                    color: Colors.red)),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => const StudentDetails());
                            },
                          );
                        },
                      );
              }
            }),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => CreateStudent(onSubmit:
                          (firstName, lastName, course, year, enrolled) async {
                        await studentDB.create(
                            firstName: firstName.toString(),
                            lastName: lastName.toString(),
                            course: course.toString(),
                            year: year.toString(),
                            enrolled: enrolled.toString());
                      }));
            }),
      );
}
