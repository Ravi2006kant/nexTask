
import 'package:flutter/material.dart';

class Tasktile extends StatefulWidget {
  const Tasktile({
    super.key,
    required this.taskName,
    required this.priority,
  });

  final String taskName;
  final int priority;

  @override
  State<Tasktile> createState() => _TasktileState();
}

class _TasktileState extends State<Tasktile> {
  TextDecoration dec = TextDecoration.none;
  bool decor = false;
  bool chk = false;

  String get priorityName {
    switch (widget.priority) {
      case 0:
        return "Low";
      case 1:
        return "Normal";
      case 2:
        return "High";
      default:
        return "Unknown";
    }
  }

  Color get priorityColor {
    switch (widget.priority) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.white;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor:
          Theme.of(context).colorScheme.inverseSurface,
          side: BorderSide(
            color: Theme.of(context).colorScheme.inverseSurface,
            width: 2,
          ),
          value: chk,
          onChanged: (value) {
            setState(() {
              chk = value ?? false;
              decor = chk;

              dec = decor
                  ? TextDecoration.lineThrough
                  : TextDecoration.none;
            });
          },
        ),

        title: Text(
          widget.taskName,
          style: TextStyle(
            decoration: dec,
            decorationThickness: 2.5,
            fontWeight: FontWeight.bold,
          ),
        ),

        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: priorityColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            priorityName,
            style: TextStyle(
              color: priorityColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
