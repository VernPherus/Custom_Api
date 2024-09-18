import 'package:api_app/widgets/student_view_widgets/data_card_text.dart';
import 'package:flutter/material.dart';

class StudentDataCard extends StatelessWidget {
  final String course;
  final String year;
  final bool enrollementStat;
  const StudentDataCard(
      {super.key,
      required this.course,
      required this.year,
      required this.enrollementStat});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Divider(
              indent: 1,
              endIndent: 1,
              thickness: 3,
              color: Colors.black,
            ),
            DataCardText(title: 'Course', data: course),
            Divider(
              indent: 1,
              endIndent: 1,
              thickness: 3,
              color: Colors.black,
            ),
            DataCardText(title: 'Year', data: year),
            Divider(
              indent: 1,
              endIndent: 1,
              thickness: 3,
              color: Colors.black,
            ),
            DataCardText(
                title: 'Enrolled',
                data: enrollementStat ? 'Enrolled' : 'Not Enrolled'),
            Divider(
              indent: 1,
              endIndent: 1,
              thickness: 3,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
