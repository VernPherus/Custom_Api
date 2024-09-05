<<<<<<< HEAD
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
=======
// ignore_for_file: use_build_context_synchronously
// TODO Fix onSubmit crash
import 'package:api_app/database/students_db.dart';
import 'package:api_app/models/student.dart';
import 'package:api_app/screens/student_view.dart';
import 'package:api_app/widgets/student_create_update.dart';
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
      futureStudents = studentDB.fetchAll();
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
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final student = students[index];
                          final subtitle = student.course.toString();
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentView(
                                            studentID: student.id,
                                          ))).then((_) {setState(() {
                                            fetchStudents();
                                          });});
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
                  barrierDismissible: false,
                  builder: (_) => Create_Update_Student(onSubmit: (student) async {
                        await studentDB.create(
                            firstName: student['firstName'],
                            lastName: student['lastName'],
                            course: student['course'],
                            year: student['year'],
                            enrolled: student['enrolled']);
                        if (!mounted) return;
                        fetchStudents();
                        Navigator.of(context).pop();
                      }));
            }),
      );
>>>>>>> parent of bc7fec6 (restructured model, removed database and unused imports)
}
