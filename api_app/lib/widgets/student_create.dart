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
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    fname_ctrlr.text = widget.student?.firstName ?? '';
    lname_ctrlr.text = widget.student?.lastName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
