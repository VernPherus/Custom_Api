import 'package:api_app/api/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:api_app/models/student.dart';

class StudentListItems extends StatefulWidget {
  const StudentListItems({super.key});

  @override
  State<StudentListItems> createState() => _StudentListItemsState();
}

class _StudentListItemsState extends State<StudentListItems> {

  final apiService = ApiService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}
