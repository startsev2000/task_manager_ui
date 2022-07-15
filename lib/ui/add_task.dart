import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_task_flutter/const/styles.dart';
import 'package:test_task_flutter/data/api.dart';
import 'package:test_task_flutter/data/task.dart';
import 'package:test_task_flutter/ui/tasks.dart';
import 'package:test_task_flutter/widgets/app_button.dart';
import 'package:test_task_flutter/widgets/app_dropdown_button.dart';
import 'package:test_task_flutter/widgets/app_text_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final controller = TextEditingController();

  final List<String> remindTimes = [
    "",
    "10 minutes early",
    "30 minutes early",
    "1 hour early"
  ];
  String? remindTime;

  final List<String> repeatTypes = ["", "Daily", "Weekly", "Monthly", "Yearly"];
  String? repeatType;

  String? deadline;
  String? startTime;
  String? endTime;

  TasksData? tasksData;

  bool isAddButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add task",
          style: AppTextStyles.titleStyle1,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer(builder: (context, ref, child) {
        Widget? body;
        ref.watch(dataProvider).when(
          data: (TasksData tasksData) {
            this.tasksData = tasksData;
            body = Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Text(
                            "Title",
                            style: AppTextStyles.titleStyle2,
                          ),
                        ),
                        AppTextField(
                          textEditingController: controller,
                          hintText: "Design team meeting",
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Text(
                            "Deadline",
                            style: AppTextStyles.titleStyle2,
                          ),
                        ),
                        AppButton(
                          onPressed: () {
                            _fetchDate();
                          },
                          hintText: deadline ?? "2021-02-28",
                          hintIcon: const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.grey,
                          ),
                          textColor:
                              deadline != null ? Colors.black : Colors.grey,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                    child: Text(
                                      "Start time",
                                      style: AppTextStyles.titleStyle2,
                                    ),
                                  ),
                                  AppButton(
                                    onPressed: () {
                                      _fetchTime(true);
                                    },
                                    hintText: startTime ?? "11:00 AM",
                                    hintIcon: const Icon(
                                      Icons.access_time,
                                      color: Colors.grey,
                                    ),
                                    textColor: startTime != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                    child: Text(
                                      "End time",
                                      style: AppTextStyles.titleStyle2,
                                    ),
                                  ),
                                  AppButton(
                                    onPressed: () {
                                      _fetchTime(false);
                                    },
                                    hintText: endTime ?? "14:00 PM",
                                    hintIcon: const Icon(
                                      Icons.access_time,
                                      color: Colors.grey,
                                    ),
                                    textColor: endTime != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Text(
                            "Remind",
                            style: AppTextStyles.titleStyle2,
                          ),
                        ),
                        AppDropdownButton(
                          items: remindTimes,
                          onChanged: (String? remindTimeChosen) {
                            setState(() {
                              if (remindTimeChosen != null) {
                                remindTime = remindTimeChosen;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Text(
                            "Repeat",
                            style: AppTextStyles.titleStyle2,
                          ),
                        ),
                        AppDropdownButton(
                          items: repeatTypes,
                          onChanged: (String? repeatTypeChosen) {
                            setState(() {
                              if (repeatTypeChosen != null) {
                                repeatType = repeatTypeChosen;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: AppButton(
                      onPressed: !isAddButtonEnabled
                          ? null
                          : () {
                              if (remindTime != null &&
                                  remindTime != "" &&
                                  repeatType != null &&
                                  repeatType != "" &&
                                  deadline != null &&
                                  startTime != null &&
                                  endTime != null &&
                                  controller.value.text != "") {
                                tasksData.addTask(
                                  // В продакшене некорректно добавлять задания с одним и тем же id,
                                  // это остаётся только в рамках тестового задания.
                                  Task(
                                    id: 22,
                                    userId: 1231,
                                    title: controller.value.text,
                                    dueOn: deadline!,
                                    status: "pending",
                                  ),
                                );
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Success"),
                                      content:
                                          const Text("You have added a task"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Tasks(),
                                              ),
                                              (r) => false,
                                            );
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "You haven't filled all the fields"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                setState(() {
                                  isAddButtonEnabled = false;
                                });
                                Timer(const Duration(seconds: 2), () {
                                  setState(() {
                                    isAddButtonEnabled = true;
                                  });
                                });
                              }
                            },
                      hintText: "Create a Task",
                      fillColor: isAddButtonEnabled
                          ? Colors.green
                          : const Color(0xFFA3FFBC),
                      textColor: Colors.white,
                      isCentered: true,
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            body = const Center(child: Text("An error occured"));
          },
          loading: () {
            body = const Center(child: CircularProgressIndicator());
          },
        );
        return body ?? Container();
      }),
    );
  }

  void _fetchTime(bool isStartTime) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      var hour = time.hour;
      var minute = time.minute;
      String dayPart = "PM";
      if (hour >= 0 && hour < 12) {
        dayPart = "AM";
      }
      var strMinute = minute.toString();
      if (minute >= 0 && minute <= 9) {
        strMinute = "0$minute";
      }
      setState(() {
        if (isStartTime) {
          startTime = "${time.hour}:$strMinute $dayPart";
        } else {
          endTime = "${time.hour}:$strMinute $dayPart";
        }
      });
    }
  }

  void _fetchDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        String strMonth = date.month.toString();
        String strDay = date.day.toString();
        if (date.month >= 0 && date.month <= 9) {
          strMonth = "0${date.month}";
        }
        if (date.day >= 0 && date.day <= 9) {
          strDay = "0${date.day}";
        }
        deadline = "${date.year}-$strMonth-$strDay";
      });
    }
  }
}
