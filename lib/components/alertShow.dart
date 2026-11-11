import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AlertShow extends StatelessWidget {
  AlertShow({
    super.key,
    required this.title,
    required this.des,
    required this.date,
    required this.priority,
  });
  String title;
  String des;
  String date;
  int priority;

  @override
  Widget build(BuildContext context) {
    String hehe() {
      if (priority == 0) {
        return "Low";
      } else if (priority == 1) {
        return "normal";
      } else {
        return "High";
      }
    }
    String formattedDate = DateFormat('dd MMM yyyy').format(
      DateTime.parse(date),
    );

    List<String> data = [title, formattedDate, des, hehe()];
    List<String> info = ['Task Name', 'Date', 'Description', 'Priority'];

    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.amber,

          borderRadius: BorderRadiusGeometry.circular(25),
        ),
        child: Text('Task Details', style: TextStyle(fontWeight: .bold)),
      ),

      content: SizedBox(
        height: 270,
        width: 300,
        child: ListView.builder(
          itemCount: info.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: Text(
                    "${info[index]} -",
                    style: TextStyle(fontSize: 15, fontWeight: .bold),
                  ),
                  title: Text(data[index]),
                ),
                if (index != info.length - 1)
                  Divider(color: Colors.grey, thickness: 1.5),
              ],
            );
          },
        ),
      ),
    );
  }
}
