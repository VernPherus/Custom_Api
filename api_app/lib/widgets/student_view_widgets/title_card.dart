import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final String titleText;
  const TitleCard({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14.0),
          bottomRight: Radius.circular(14.0),
        ),
      ),
      color: Colors.orange,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.white,
                    height: 40,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
