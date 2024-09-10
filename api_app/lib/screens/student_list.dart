import 'package:api_app/api/api_service.dart';
import 'package:api_app/screens/student_view.dart';
import 'package:api_app/widgets/student_form.dart';
import 'package:api_app/widgets/student_list_item.dart';
import 'package:flutter/material.dart';
import 'package:api_app/models/student.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  Future<List<Student>>? futureStudent;
  final api_service = ApiService();

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Student List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder(
          future: futureStudent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final students = snapshot.data!;

              return students.isEmpty
                  ? const Center(
                      child: Text(
                      'No student data',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
                  : ListView.separated(
                    padding: EdgeInsets.only(bottom: 100),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 0.0),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return StudentListItem(
                          StudentID: student.id,
                          fname: student.firstName,
                          lname: student.lastName,
                          year: student.year,
                          course: student.course,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudentView(id: student.id))).then((_) {
                              setState(() {
                                getStudents();
                              });
                            });
                          },
                          onPress: () async {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: const Text(
                                          'Are you sure you want to delete this student?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {
                                              await api_service
                                                  .deleteStudent(student.id);
                                              getStudents();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Confirm')),
                                      ],
                                    ));
                          },
                        );
                      },
                    );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.orange,
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => StudentForm(onSubmit: (student) async {
                        await api_service.createStudent(
                            fname: student['fname'],
                            lname: student['lname'],
                            course: student['course'],
                            year: student['year'],
                            enrolled: student['enrolled']);
                        if (!mounted) return;
                        getStudents();
                        Navigator.of(context).pop();
                      }));
            }),
      );
}
