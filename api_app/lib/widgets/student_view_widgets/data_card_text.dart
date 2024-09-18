import 'package:flutter/material.dart';

class DataCardText extends StatelessWidget {
  final String title;
  final String data;
  const DataCardText({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0),
          child: Text(
            data,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
          ),
        )
      ],
    );
  }
}
