import "package:flutter/material.dart";

void main() {
  runApp(const Index());
}

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Student API",
        home: const Placeholder());
  }
}
