import 'package:flutter/material.dart';

class AlertShow extends StatelessWidget {
  const AlertShow({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
          child: Text("Show the task detail here...",style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
