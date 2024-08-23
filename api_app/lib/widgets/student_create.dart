// TODO rewrite the form to be used in a real page
// TODO figure out how to submit form and return to student_list

import 'package:flutter/material.dart';
import 'package:api_app/models/student.dart';

class CreateStudent extends StatefulWidget {
  final Student? student;
  final ValueChanged<String> onSubmit;

  const CreateStudent({super.key, this.student, required this.onSubmit});

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  final fname_ctrlr = TextEditingController();
  final lname_ctrlr = TextEditingController();
  final course = TextEditingController();
  late final String year;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    fname_ctrlr.text = widget.student?.firstName ?? '';
    lname_ctrlr.text = widget.student?.lastName ?? '';
    course.text = widget.student?.course ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;
    bool _isEnrolled = false;
    return AlertDialog(
      title: Text(isEditing ? 'Edit Student' : 'Add Student'),
      content: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: fname_ctrlr,
                decoration: const InputDecoration(hintText: 'First name'),
                validator: (value) => value != null && value.isEmpty
                    ? 'First name is required'
                    : null,
              ),
              TextFormField(
                autofocus: true,
                controller: lname_ctrlr,
                decoration: const InputDecoration(hintText: 'Last name'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Last name is required'
                    : null,
              ),
              TextFormField(
                autofocus: true,
                controller: course,
                decoration: const InputDecoration(hintText: 'Course'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Course is required'
                    : null,
              ),
              DropdownMenu(
                  enableFilter: false,
                  onSelected: (value) => value != null
                      ? setState(() {
                          year = value;
                        })
                      : null,
                  label: const Text('Year'),
                  dropdownMenuEntries: <DropdownMenuEntry<String>>[
                    DropdownMenuEntry(value: 'First Year', label: 'First Year'),
                    DropdownMenuEntry(
                        value: 'Second Year', label: 'Second Year'),
                    DropdownMenuEntry(value: 'Third Year', label: 'Third Year'),
                    DropdownMenuEntry(
                        value: 'Fourth Year', label: 'Fourth Year'),
                    DropdownMenuEntry(value: 'Fifth Year', label: 'Fifth Year'),
                  ]),
              Row(
                children: [
                  Text('Enrolled: '),
                  Switch(
                      value: _isEnrolled,
                      onChanged: (bool value) {
                        setState(() {
                          _isEnrolled = value;
                        });
                      })
                ],
              ),
            ],
          )),
    );
  }
}
