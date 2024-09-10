import 'package:api_app/api/api_service.dart';
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
      padding: EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0),
      child: ListTile(
        leading: Icon(Icons.person_2_sharp),
        title: Text(
          '$fname $lname',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$year\n$course',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        trailing: IconButton(
          onPressed: onPress,
          icon: Icon(Icons.delete),
          color: Colors.red,
          iconSize: 35.0,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(
              color: Colors.black,
              width: 1,
            )),
      ),
    );
  }
}
