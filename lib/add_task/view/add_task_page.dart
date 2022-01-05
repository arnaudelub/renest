import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:renest/add_task/widgets/task_box.dart';
import 'package:renest/core/app_config.dart';
import 'package:renest/core/constant.dart';
import 'package:renest/home/cubit/cubit/tasks_cubit.dart';
import 'package:renest/style/style.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<TasksCubit>().getPrioritizedTasks();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              addTask,
              style: Theme.of(context)
                  .appBarTheme
                  .titleTextStyle!
                  .copyWith(fontWeight: FontWeight.w500),
            )),
        body: const Padding(
          padding: EdgeInsets.only(top: mediumPadding),
          child: AddTaskView(),
        ),
      ),
    );
  }
}

class AddTaskView extends StatelessWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = context.select((TasksCubit cubit) => cubit.state);
    debugPrint("Tasks are $tasks");
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        itemCount: tasks?.length ?? 0,
        itemBuilder: (context, i) {
          final Map<String, String> item = tasks![i];
          return Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding),
            child: TaskBox(text: item.keys.first),
          );
        });
  }
}
