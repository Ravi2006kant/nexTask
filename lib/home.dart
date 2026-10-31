import 'package:flutter/material.dart';
import 'package:nextask/components/fabSheet.dart';
import 'package:nextask/database/dbHelper.dart';
import 'package:nextask/theme/themeProvider.dart';
import 'package:provider/provider.dart';

import 'components/tasktile.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var task ;
  bool isdark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "TO DO LIST",
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
        leading: IconButton(
          onPressed: () {
            context.read<ThemeProvider>().trigger();
            isdark = !isdark;
          },
          icon: Icon(
            isdark == false ? Icons.nightlight : Icons.wb_sunny_outlined,
            color: Colors.white,
          ),
        ),
        actions: [

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Tasktile(taskName: task[index]);
              },
            ),
          ),

         //  Expanded(child: ElevatedButton(onPressed: ()async{
         //
         // final take =  await DbHelper.getInstance().fetchTask();
         //
         //
         //  }, child: Text("test")))
        ],
      ),
      floatingActionButton: Fabsheet(),
    );
  }
}
