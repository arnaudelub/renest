import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:renest/core/constant.dart';
import 'package:renest/home/cubit/cubit/tasks_cubit.dart';
import 'package:renest/style/style.dart';

class PriorityBox extends StatelessWidget {
  const PriorityBox(
      {Key? key,
      required this.color,
      required this.priority,
      required this.task,
      required this.callback})
      : super(key: key);

  final Color color;
  final Priority priority;
  final String task;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TasksCubit>().addTask(task, priority);
        callback();
      },
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
          child: Text(
            _getTextFromPriority(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: reNestWhite),
          ),
        ),
      ),
    );
  }

  String _getTextFromPriority() {
    switch (priority) {
      case Priority.high:
        return highPriority;
      case Priority.normal:
        return normalPriority;
      case Priority.low:
        return lowPriority;
    }
  }
}
