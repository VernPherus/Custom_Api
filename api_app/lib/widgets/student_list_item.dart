import 'package:api_app/api/api_service.dart';
import 'package:api_app/screens/student_view.dart';
import 'package:flutter/material.dart';

class StudentListItem extends StatefulWidget {
  final String StudentID;
  final String fname;
  final String lname;
  final String year;
  final String course;
  final Function()? onTap;
  final Function()? onPress;

  const StudentListItem(
      {super.key,
      required this.StudentID,
      required this.fname,
      required this.lname,
      required this.year,
      required this.course,
      this.onTap,
      this.onPress});

  @override
  State<StudentListItem> createState() => _StudentListItemState();
}

class _StudentListItemState extends State<StudentListItem> {
  final api_service = ApiService();
  String id = '';
  String fname = '';
  String lname = '';
  String course = '';
  String year = '';
  Function()? onTap;
  Function()? onPress;

  @override
  void initState() {
    super.initState();

    id = widget.StudentID;
    fname = widget.fname;
    lname = widget.lname;
    course = widget.course;
    year = widget.year;
    onTap = widget.onTap;
    onPress = widget.onPress;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
          title: Text('$fname $lname'),
          subtitle: Text('$year, $course'),
          trailing: IconButton(onPressed: onPress, icon: Icon(Icons.delete)),
          onTap: onTap),
    );
  }
}
