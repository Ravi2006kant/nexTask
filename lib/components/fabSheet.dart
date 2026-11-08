import 'package:flutter/material.dart';
import 'package:nextask/components/dataInput.dart';
import 'package:nextask/database/dbHelper.dart';
import 'package:provider/provider.dart';
import '../taskProvider.dart';

class Fabsheet extends StatefulWidget {
  const Fabsheet({super.key});

  @override
  State<Fabsheet> createState() => _FabsheetState();
}

enum Priority { Low, Normal, High }

class _FabsheetState extends State<Fabsheet> {
  final textController = TextEditingController();
  final descController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  bool isTaskEmpty = false;

  Future<void> datepick(StateSetter sets) async {
    final take = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (take != null) {
      sets(() {
        selectedDate = take;
      });
    }
  }

  Priority selectedPriority = Priority.Low;

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
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(50),
      ),
      onPressed: () {
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
                    color: Theme.of(context).colorScheme.onPrimary,
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
                        test(inp: "Task Name"),
                        DataInput(
                          controller: textController,
                          htext: "Enter Task here.",
                          cr: isTaskEmpty ? Colors.red : Colors.grey,
                          br: BorderSide(
                            color: isTaskEmpty ? Colors.red : Colors.grey,
                            width: isTaskEmpty ? 3:2,
                          ),
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              sets(() {
                                isTaskEmpty = false;
                              });
                            }
                          },
                        ),
                        test(inp: "Description"),

                        DataInput(controller: descController,htext: "Enter Description here."),
                        test(inp: "Priority"),
                        SegmentedButton(
                          multiSelectionEnabled: false,

                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color?>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.amber;
                                  }
                                  return Colors.transparent;
                                }),
                            foregroundColor:
                                WidgetStateProperty.resolveWith<Color?>((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.selected)) {
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
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            ButtonSegment(
                              value: Priority.Normal,
                              label: Text(
                                "Normal",
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            ButtonSegment(
                              value: Priority.High,

                              label: Text(
                                "High",
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                          ],
                          selected: {selectedPriority},
                          onSelectionChanged: (Set<Priority> newSelection) {
                            sets(() {
                              selectedPriority = newSelection.first;
                            });
                          },
                        ),
                        test(inp: "Due Date"),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'No date selected',
                            suffixIcon: IconButton(
                              onPressed: () => datepick(sets),
                              icon: const Icon(Icons.calendar_month_rounded),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.amber,
                              ),
                            ),
                            onPressed: () async {

                              final taskName = textController.text.trim();

                              if (taskName.isEmpty) {
                                sets(() {
                                  isTaskEmpty = true;
                                });
                                return;
                              }

                              await DbHelper.getInstance().addTask(
                                taskInput: taskName,
                                dateInput:
                                    selectedDate?.toIso8601String() ??
                                    DateTime.now().toIso8601String(),
                                priorityInput: priority(),
                                statusInput: false,
                              );

                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Task Saved")),
                              );

                              textController.clear();
                              descController.clear();
                              selectedDate = DateTime.now();
                              selectedPriority = Priority.Low;
                              Navigator.pop(context);

                              await context.read<TaskProvider>().loadData();
                            },
                            child: Text(
                              "Save",
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
      child: Icon(Icons.add, color: Colors.white, fontWeight: .bold),
    );
  }

  Widget test({required inp}) {
    return Text(inp, style: TextStyle(fontWeight: .bold));
  }
}
