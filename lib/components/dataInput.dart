import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataInput extends StatelessWidget {
  DataInput({super.key, required this.controller});
  final controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: .text,
      decoration: InputDecoration(

        enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.grey.shade900),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.amber,width: 2),
        ),
      ),
    );
  }
}
