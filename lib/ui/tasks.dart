import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_task_flutter/animation/custom_page_route.dart';
import 'package:test_task_flutter/data/api.dart';
import 'package:test_task_flutter/ui/add_task.dart';
import 'package:test_task_flutter/widgets/app_button.dart';
import 'package:test_task_flutter/const/styles.dart';
import 'package:test_task_flutter/widgets/app_check_box.dart';

import '../data/task.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List<String> numbers = ["1", "2", "3", "4", "5"];
  final List<String> types = [
    "All",
    "Completed",
    "Uncompleted",
    "Favorite",
    "Pending",
    "Other"
  ];

  TasksData? tasksData;
  TasksData? duplicateTasksData;
  Map<int, bool> checkboxes = {};

  bool isSearchVisible = false;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: isSearchVisible
            ? null
            : Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Board",
                  style: AppTextStyles.titleStyle1,
                ),
              ),
        actions: <Widget>[
          isSearchVisible
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Board",
                      style: AppTextStyles.titleStyle1,
                    ),
                  ),
                )
              : Container(),
          Visibility(
            visible: isSearchVisible,
            child: Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  _search(value);
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isSearchVisible = !isSearchVisible;
              });
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.view_headline_sharp,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Consumer(
          builder: (context, ref, child) {
            Widget? body;
            ref.watch(dataProvider).when(
              data: (TasksData tasksData) {
                this.tasksData = tasksData;
                duplicateTasksData = tasksData;
                body = Column(
                  children: <Widget>[
                    const Divider(),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: types.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  types[index],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: tasksData.tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (!checkboxes
                              .containsKey(tasksData.tasks[index].id)) {
                            checkboxes[tasksData.tasks[index].id] = true;
                          }
                          Color checkBoxColor;
                          switch (tasksData.tasks[index].status) {
                            case "completed":
                              checkBoxColor = Colors.green;
                              break;
                            case "pending":
                              checkBoxColor = Colors.yellow;
                              break;
                            default:
                              checkBoxColor = Colors.red;
                              break;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: AppCheckBox(
                                    isChecked:
                                        checkboxes[tasksData.tasks[index].id]!,
                                    onPressed: () {},
                                    selectedColor: checkBoxColor,
                                    unselectedColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                    tasksData.tasks[index].title,
                                    style: AppTextStyles.basicStyle1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(10.0),
                      child: AppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            AppPageRoute(
                              child: const AddTask(),
                            ),
                          );
                        },
                        hintText: "Add a Task",
                        fillColor: Colors.green,
                        textColor: Colors.white,
                        isCentered: true,
                      ),
                    ),
                  ],
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
          },
        ),
      ),
    );
  }

  // Поиск на данный момент не реализован до конца. To be continued
  void _search(String query) {
    if (tasksData != null) {
      final searched = duplicateTasksData!.tasks.where((Task task) {
        String taskTitle = task.title.toLowerCase();
        String input = query.toLowerCase();

        return taskTitle.contains(input);
      }).toList();

      setState(() {
        tasksData!.tasks = searched;
      });
    }
  }
}
