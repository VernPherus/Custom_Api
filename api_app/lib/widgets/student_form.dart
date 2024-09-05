import 'dart:async';

import 'package:api_app/models/student.dart';
import 'package:flutter/material.dart';

class StudentForm extends StatefulWidget {
  final Student? student;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const StudentForm({Key? key, this.student, required this.onSubmit})
      : super(key: key);

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final courseController = TextEditingController();
  String yearVal = 'First Year';
  bool enrolledVal = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    fnameController.text = widget.student?.firstName ?? '';
    lnameController.text = widget.student?.lastName ?? '';
    courseController.text = widget.student?.course ?? '';
    yearVal = widget.student?.year ?? '';
    enrolledVal = widget.student?.enrolled ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;
    return AlertDialog(
      title: Text(isEditing ? 'Update Student Data' : 'Add Student Data'),
      content: Form(
        child: Padding(
            padding: EdgeInsets.all(9),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            autofocus: true,
                            controller: fnameController,
                            decoration:
                                const InputDecoration(hintText: 'First Name'),
                            validator: (value) => value != null && value.isEmpty
                                ? 'First name is required'
                                : null,
                          ),
                          TextFormField(
                            autofocus: true,
                            controller: lnameController,
                            decoration:
                                const InputDecoration(hintText: 'Last Name'),
                            validator: (value) => value != null && value.isEmpty
                                ? 'Last name is required'
                                : null,
                          ),
                          TextFormField(
                            autofocus: true,
                            controller: courseController,
                            decoration:
                                const InputDecoration(hintText: 'Course'),
                            validator: (value) => value != null && value.isEmpty
                                ? 'Course is required'
                                : null,
                          ),
                        ],
                      ),
                    ),
                    DropdownMenu(
                        initialSelection: yearVal,
                        enableFilter: false,
                        onSelected: (value) => value != null
                            ? setState(() {
                                yearVal = value;
                              })
                            : null,
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                              value: 'First Year', label: 'First Year'),
                          DropdownMenuEntry(
                              value: 'Second Year', label: 'Second Year'),
                          DropdownMenuEntry(
                              value: 'Third Year', label: 'Third Year'),
                          DropdownMenuEntry(
                              value: 'Fourth Year', label: 'Fourth Year'),
                          DropdownMenuEntry(
                              value: 'Fifth Year', label: 'Fifth Year'),
                        ]),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text('Enrolled: '),
                          Switch(
                              value: enrolledVal,
                              onChanged: (bool value) {
                                setState(() {
                                  enrolledVal = value;
                                });
                              })
                        ],
                      ),
                    )
                  ],
                ))),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.onSubmit({
                  'fname': fnameController.text,
                  'lname': lnameController.text,
                  'course': courseController.text,
                  'year': yearVal,
                  'enrolled': enrolledVal
                });
              }
            },
            child: const Text('Submit'))
      ],
    );
  }
}
