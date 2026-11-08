import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nextask/components/alertShow.dart';
import 'package:nextask/components/fabSheet.dart';
import 'package:nextask/components/homeDrawer.dart';
import 'package:nextask/database/dbHelper.dart';
import 'package:nextask/taskProvider.dart';
import 'package:nextask/theme/themeProvider.dart';
import 'package:provider/provider.dart';

import 'components/tasktile.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeProvider>().loadTheme();
    context.read<TaskProvider>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    final test = context.watch<TaskProvider>().task;
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("TO DO LIST", style: TextStyle(fontWeight: .bold)),
      ),
      body: test.isEmpty
          ? Center(
              child: Text("No Tasks Available ", style: TextStyle(fontSize: 20,fontWeight: .bold),
            ))
          : ListView.builder(
              itemCount: context.watch<TaskProvider>().task.length,
              itemBuilder: (context, index) {
                final tasks = context.watch<TaskProvider>().task;
                return Slidable(
                  key: ValueKey(tasks[index]['id']),
                  closeOnScroll: true,
                  endActionPane: ActionPane(
                    dismissible: DismissiblePane(
                      onDismissed: () async {
                        await DbHelper.getInstance().deleteTask(
                          id: tasks[index]['id'],
                        );
                        await context.read<TaskProvider>().loadData();
                      },
                    ),

                    motion: const ScrollMotion(),
                    extentRatio: 0.5,
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await DbHelper.getInstance().deleteTask(
                            id: tasks[index]['id'],
                          );
                          await context.read<TaskProvider>().loadData();
                        },

                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  ),
                  // return GestureDetector(
                  //   onLongPress: () async {
                  //
                  //     await DbHelper.getInstance().deleteTask(id:task[index]['id']);
                  //     await loadData();
                  //   },
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertShow();
                        },
                      );
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            actions: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [Text("Update the data")],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Tasktile(taskName: tasks[index]["task"]),
                  ),
                );
              },
            ),
      floatingActionButton: Fabsheet(),
    );
  }
}
