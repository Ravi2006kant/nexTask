import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tasktile extends StatefulWidget {
  Tasktile({super.key,required this.taskName});
String taskName;

  @override
  State<Tasktile> createState() => _TasktileState();
}

class _TasktileState extends State<Tasktile> {
TextDecoration dec = .none;
bool decor = false;
bool chk =false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 15,left: 20,right: 20),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Checkbox(value: chk, onChanged: (context){
          setState(() {
            chk = !chk;
          decor = !decor;
            decor ? (dec = TextDecoration.lineThrough) :  (dec = TextDecoration.none  );
          });


        }),
        title: Text(widget.taskName,style: TextStyle(decoration: dec,fontWeight: .bold),),
      ),
    );
  }
}
