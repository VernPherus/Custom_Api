// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:api_app/models/student.dart';

class Create_Update_Student extends StatefulWidget {
  final Student? student;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const Create_Update_Student(
      {super.key, this.student, required this.onSubmit});

  @override
  State<Create_Update_Student> createState() => _Create_Update_StudentState();
}

class _Create_Update_StudentState extends State<Create_Update_Student> {
  final fname_ctrlr = TextEditingController();
  final lname_ctrlr = TextEditingController();
  final course = TextEditingController();
  String year = 'First Year';
  bool isEnrolled = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    fname_ctrlr.text = widget.student?.firstName ?? '';
    lname_ctrlr.text = widget.student?.lastName ?? '';
    course.text = widget.student?.course ?? '';
    year = widget.student?.year ?? 'First Year';
    isEnrolled = widget.student?.enrolled ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Student' : 'Add Student'),
      content: Form(
          key: formKey,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
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
                ],
              ),
            ),
            DropdownMenu(
                initialSelection: year,
                enableFilter: false,
                onSelected: (value) => value != null
                    ? setState(() {
                        year = value;
                      })
                    : null,
                label: const Text('Year'),
                dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                  DropdownMenuEntry(value: 'First Year', label: 'First Year'),
                  DropdownMenuEntry(value: 'Second Year', label: 'Second Year'),
                  DropdownMenuEntry(value: 'Third Year', label: 'Third Year'),
                  DropdownMenuEntry(value: 'Fourth Year', label: 'Fourth Year'),
                  DropdownMenuEntry(value: 'Fifth Year', label: 'Fifth Year'),
                ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Enrolled: '),
                  Switch(
                      value: isEnrolled,
                      onChanged: (bool value) {
                        setState(() {
                          isEnrolled = value;
                        });
                      })
                ],
              ),
            ),
          ])),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.onSubmit({
                  'firstName': fname_ctrlr.text,
                  'lastName': lname_ctrlr.text,
                  'course': course.text,
                  'year': year,
                  'enrolled': isEnrolled ? 0 : 1,
                });
              }
            },
            child: const Text('Submit'))
      ],
    );
  }
}
