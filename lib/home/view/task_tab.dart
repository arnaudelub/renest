import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:renest/core/constant.dart';
import 'package:renest/home/cubit/cubit/tasks_cubit.dart';
import 'package:renest/style/style.dart';

class TaskTab extends StatelessWidget {
  const TaskTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = context.select((TasksCubit cubit) => cubit.state);
    debugPrint("Got tasks $tasks");
    if (tasks == null || tasks.isEmpty) {
      return const Center(child: Text("No tasks yet!"));
    }
    return ListView(
      children: [
        PriorityTasksBox(
            tasks: _getHighPriorityTasks(tasks), priority: Priority.high),
        PriorityTasksBox(
            tasks: _getNormalPriorityTasks(tasks), priority: Priority.normal),
        PriorityTasksBox(
            tasks: _getLowPriorityTasks(tasks), priority: Priority.low),
      ],
    );
  }

  List<String?> _getHighPriorityTasks(List<Map<String, String>>? tasks) {
    if (tasks == null || tasks.isEmpty) {
      return [];
    }
    return tasks
        .where((element) => element.values.first == Priority.high.name)
        .map((element) => element.keys.first)
        .toList();
  }

  List<String?> _getNormalPriorityTasks(List<Map<String, String>>? tasks) {
    if (tasks == null || tasks.isEmpty) {
      return [];
    }
    return tasks
        .where((element) => element.values.first == Priority.normal.name)
        .map((element) => element.keys.first)
        .toList();
  }

  List<String?> _getLowPriorityTasks(List<Map<String, String>>? tasks) {
    if (tasks == null || tasks.isEmpty) {
      return [];
    }
    return tasks
        .where((element) => element.values.first == Priority.low.name)
        .map((element) => element.keys.first)
        .toList();
  }
}

class PriorityTasksBox extends StatelessWidget {
  const PriorityTasksBox(
      {Key? key, required this.tasks, required this.priority})
      : super(key: key);

  final List<String?> tasks;
  final Priority priority;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      color: reNestAccentWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: mediumPadding, top: mediumPadding),
              child: _getTextFromPriority()),
          for (final task in tasks) ...[
            Container(
              padding: const EdgeInsets.only(
                  left: bigPadding, top: mediumPadding, bottom: mediumPadding),
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultBorderRadius)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => debugPrint("Todo"),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: reNestGreyDarker),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: smallPadding,
                  ),
                  Text(task!)
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
          ]
        ],
      ),
    );
  }

  Widget _getTextFromPriority() {
    switch (priority) {
      case Priority.high:
        return const Text(highPriority,
            style: TextStyle(
              color: reNestRed,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ));
      case Priority.normal:
        return const Text(normalPriority,
            style: TextStyle(
              color: reNestGreen,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ));
      case Priority.low:
        return const Text(lowPriority,
            style: TextStyle(
              color: reNestBlue,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ));
    }
  }
}
