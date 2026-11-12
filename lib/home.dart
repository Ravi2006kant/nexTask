import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nextask/components/alertShow.dart';
import 'package:nextask/components/fabSheet.dart';
import 'package:nextask/components/homeDrawer.dart';
import 'package:nextask/database/dbHelper.dart';
import 'package:nextask/taskProvider.dart';
import 'package:nextask/theme/themeProvider.dart';
import 'package:provider/provider.dart';

import 'components/dataInput.dart';
import 'components/tasktile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textController = TextEditingController();
  final descController = TextEditingController();

  DateTime? selectedDate;
  bool isTaskEmpty = false;

  Priority selectedPriority = Priority.Low;

  Future<void> datepick(StateSetter sets) async {
    final take = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      initialDate: selectedDate ?? DateTime.now(),
    );

    if (take != null) {
      sets(() {
        selectedDate = take;
      });
    }
  }

  String descrip() {
    if (descController.text.trim().isEmpty) {
      return "No data";
    } else {
      return descController.text.trim();
    }
  }

  int priority() {
    if (selectedPriority == Priority.Low) {
      return 0;
    } else if (selectedPriority == Priority.Normal) {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ThemeProvider>().loadTheme();
    context.read<TaskProvider>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().task;

    return Scaffold(
      drawer: HomeDrawer(),

      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("TO DO LIST", style: TextStyle(fontWeight: .bold)),
      ),

      body: tasks.isEmpty
          ? Center(
              child: Text(
                "No Tasks Available",
                style: TextStyle(fontSize: 20, fontWeight: .bold),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final currentTask = tasks[index];

                return Slidable(
                  key: ValueKey(currentTask['id']),
                  closeOnScroll: true,

                  endActionPane: ActionPane(
                    dismissible: DismissiblePane(
                      onDismissed: () async {
                        await DbHelper.getInstance().deleteTask(
                          id: currentTask['id'],
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
                            id: currentTask['id'],
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

                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertShow(
                            title: currentTask['task'],
                            date: currentTask['date'],
                            des: currentTask['desc'],
                            priority: currentTask['priority'],
                          );
                        },
                      );
                    },

                    onLongPress: () {
                      // Load existing task details
                      textController.text = currentTask['task'] ?? '';

                      descController.text = currentTask['desc'] ?? '';

                      selectedPriority =
                          Priority.values[currentTask['priority']];

                      selectedDate = DateTime.tryParse(
                        currentTask['date'] ?? '',
                      );

                      isTaskEmpty = false;

                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        enableDrag: true,
                        isScrollControlled: true,

                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, sets) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25),
                                ),

                                height: 500,
                                width: double.infinity,

                                child: Padding(
                                  padding: const EdgeInsets.all(20),

                                  child: Column(
                                    crossAxisAlignment: .start,
                                    mainAxisAlignment: .spaceEvenly,

                                    children: [
                                      tet(inp: "Task Name"),

                                      DataInput(
                                        controller: textController,
                                        htext: currentTask['task'],
                                        cr: isTaskEmpty
                                            ? Colors.red
                                            : Colors.grey,
                                        br: BorderSide(
                                          color: isTaskEmpty
                                              ? Colors.red
                                              : Colors.grey,
                                          width: isTaskEmpty ? 3 : 2,
                                        ),
                                        onChanged: (value) {
                                          if (value.trim().isNotEmpty) {
                                            sets(() {
                                              isTaskEmpty = false;
                                            });
                                          }
                                        },
                                      ),

                                      tet(inp: "Description"),

                                      DataInput(
                                        controller: descController,
                                        htext: currentTask['desc'],
                                      ),

                                      tet(inp: "Priority"),

                                      SegmentedButton<Priority>(
                                        multiSelectionEnabled: false,

                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.resolveWith<
                                                Color?
                                              >((states) {
                                                if (states.contains(
                                                  WidgetState.selected,
                                                )) {
                                                  return Colors.amber.shade300;
                                                }
                                                return Colors.transparent;
                                              }),

                                          foregroundColor:
                                              WidgetStateProperty.resolveWith<
                                                Color?
                                              >((states) {
                                                if (states.contains(
                                                  WidgetState.selected,
                                                )) {
                                                  return Colors.black;
                                                }
                                                return Colors.grey;
                                              }),
                                        ),

                                        showSelectedIcon: false,

                                        segments: [
                                          ButtonSegment(
                                            value: Priority.Low,
                                            label: Text(
                                              "Low",
                                              style: TextStyle(
                                                fontWeight: .bold,
                                              ),
                                            ),
                                          ),

                                          ButtonSegment(
                                            value: Priority.Normal,
                                            label: Text(
                                              "Normal",
                                              style: TextStyle(
                                                fontWeight: .bold,
                                              ),
                                            ),
                                          ),

                                          ButtonSegment(
                                            value: Priority.High,
                                            label: Text(
                                              "High",
                                              style: TextStyle(
                                                fontWeight: .bold,
                                              ),
                                            ),
                                          ),
                                        ],

                                        selected: {selectedPriority},

                                        onSelectionChanged:
                                            (Set<Priority> newSelection) {
                                              sets(() {
                                                selectedPriority =
                                                    newSelection.first;
                                              });
                                            },
                                      ),

                                      tet(inp: "Due Date"),

                                      TextField(
                                        readOnly: true,

                                        decoration: InputDecoration(
                                          hintText: selectedDate != null
                                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                              : 'No date selected',

                                          suffixIcon: IconButton(
                                            onPressed: () => datepick(sets),
                                            icon: const Icon(
                                              Icons.calendar_month_rounded,
                                            ),
                                          ),

                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Colors.amber,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: .center,

                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                  Colors.amber.shade300,
                                                ),
                                          ),

                                          onPressed: () async {
                                            final taskName = textController.text
                                                .trim();

                                            if (taskName.isEmpty) {
                                              sets(() {
                                                isTaskEmpty = true;
                                              });
                                              return;
                                            }

                                            await DbHelper.getInstance()
                                                .updateTask(
                                                  id: currentTask['id'],
                                                  task: taskName,
                                                  des: descrip(),
                                                  priority: priority(),
                                                  date:
                                                      selectedDate
                                                          ?.toIso8601String() ??
                                                      DateTime.now()
                                                          .toIso8601String(),
                                                );

                                            if (!mounted) return;

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  const SnackBar(
                                                    content: Text("Task Saved"),
                                                  ),
                                                );

                                            textController.clear();
                                            descController.clear();

                                            selectedDate = null;
                                            selectedPriority = Priority.Low;

                                            Navigator.pop(context);

                                            await context
                                                .read<TaskProvider>()
                                                .loadData();
                                          },

                                          child: Text(
                                            "Update",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: .bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },

                    child: Tasktile(
                      taskName: currentTask["task"],
                      priority: currentTask["priority"],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: Fabsheet(),
    );
  }

  Widget tet({required String inp}) {
    return Text(inp, style: TextStyle(fontWeight: .bold));
  }
}
