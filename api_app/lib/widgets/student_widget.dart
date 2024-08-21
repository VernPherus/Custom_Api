import 'package:flutter/material.dart';
import 'package:api_app/models/student.dart';

class StudentWidget extends StatefulWidget {
  final Student? student;
  final ValueChanged<String> onSubmit;

  const StudentWidget({Key? key, this.student, required this.onSubmit})
      : super(key: key);

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {

  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller.text = widget.student?.firstName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
