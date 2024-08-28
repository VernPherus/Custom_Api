import 'package:api_app/database/students_db.dart';
import 'package:api_app/models/student.dart';
import 'package:api_app/widgets/student_create.dart';
import 'package:flutter/material.dart';

class StudentView extends StatefulWidget {
  final int studentID;

  const StudentView({super.key, required this.studentID});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  Future<Student>? futureStudent;
  final studentDB = StudentsDB();

  @override
  void initState() {
    super.initState();

    fetchStudentData(widget.studentID);
  }

  void fetchStudentData(int studentID) {
    futureStudent = studentDB.fetchById(studentID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Details'),
        ),
        body: FutureBuilder(
            future: futureStudent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final student = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,                        children: [
                          Text(student.firstName),
                          Text(student.lastName)
                        ],
                      ),
                      Text(student.course),
                      Text(student.year),
                      Text(student.enrolled.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => CreateStudent(
                                      student: student,
                                      onSubmit: (studentUp) async {
                                        await studentDB.update(
                                            id: student.id,
                                            firstName: studentUp['firstName'],
                                            lastName: studentUp['lastName'],
                                            course: studentUp['course'],
                                            year: studentUp['year'],
                                            enrolled: studentUp['enrolled']);
                                        fetchStudentData(widget.studentID);
                                        if (!mounted) return;
                                        Navigator.of(context).pop();
                                      }));
                            },
                            child: const Text('Update'),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            }));
  }
}
