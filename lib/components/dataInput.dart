import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataInput extends StatelessWidget {
  final TextEditingController controller;
  final String htext;
  final BorderSide? br;
  final ValueChanged<String>? onChanged;
 final Color? cr;

 const DataInput({
    super.key,
    required this.controller,
    required this.htext,
    this.br,
    this.onChanged,
    this.cr
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: htext,
        hintStyle: TextStyle(color: cr ?? Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: br ?? const BorderSide(color: Colors.grey,width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.amber,
            width: 2,
          ),
        ),
      ),
    );
  }
}