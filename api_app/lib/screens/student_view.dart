import 'package:api_app/api/api_service.dart';
import 'package:api_app/models/student.dart';
import 'package:api_app/widgets/student_form.dart';
import 'package:api_app/widgets/student_view_widgets/title_card.dart';
import 'package:flutter/material.dart';

class StudentView extends StatefulWidget {
  final String id;

  const StudentView({required this.id, super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  Future<Student>? futureStudent;
  final api_service = ApiService();

  @override
  void initState() {
    super.initState();

    fetchStudent(widget.id);
  }

  void fetchStudent(String studentID) {
    setState(() {
      futureStudent = api_service.getStudentById(studentID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              padding: EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: TitleCard(
                      titleText: '${student.firstName} ${student.lastName}',
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          'Course: ${student.course}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          'Year: ${student.year}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          'Is Enrolled: ${student.enrolled}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => StudentForm(
                                          student: student,
                                          onSubmit: (updt_student) async {
                                            await api_service.updateStudent(
                                                id: student.id,
                                                fname: updt_student['fname'],
                                                lname: updt_student['lname'],
                                                course: updt_student['course'],
                                                year: updt_student['year'],
                                                enrolled:
                                                    updt_student['enrolled']);
                                            fetchStudent(widget.id);
                                            if (!mounted) return;
                                            Navigator.of(context).pop();
                                          }));
                                },
                                child: const Text("Update")),
                          )
                        ],
                      ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
