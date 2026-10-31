import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fabbutton extends StatelessWidget {
  const Fabbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(50)),
      elevation: 0,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              child: AlertDialog(
                title: Text("Enter your Task"),
                backgroundColor: Colors.amberAccent,
                actions: [
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: MaterialButton(child: Text("Cancel"), onPressed: () {
                        Navigator.pop(context);
                      })),
                      Expanded(child: MaterialButton(child: Text("OK"), onPressed: () {
                        Navigator.pop(context);
                      })),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Icon(Icons.add,color: Colors.white,fontWeight: .bold,),
    );
  }
}
