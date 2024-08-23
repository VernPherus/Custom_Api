import "package:api_app/screens/student_list.dart";
import "package:flutter/material.dart";

void main(){
  const Index();
}

class Index extends StatelessWidget {
  const Index({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student API",
      home: StudentList(),
    );
  }
}