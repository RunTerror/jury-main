import 'package:flutter/material.dart';

class tasks extends StatefulWidget {
  @override
  _tasks createState() => _tasks();
}

class _tasks extends State<tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No Tasks"),
      ),
    );
  }
}