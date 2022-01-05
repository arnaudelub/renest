import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:renest/add_task/view/add_task_page.dart';
import 'package:renest/core/app_config.dart';
import 'package:renest/core/constant.dart';
import 'package:renest/home/cubit/cubit/tasks_cubit.dart';
import 'package:renest/home/view/task_tab.dart';
import 'package:renest/home/widgets/widgets.dart';
import 'package:renest/style/style.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: reNestGreyDarker,
        ),
        title: GestureDetector(
            onLongPress: () => AppConfig.of(context)!.storage.clean(),
            child: const Text(title)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                      context.read<TasksCubit>().getAvailableTasks();
                      return const AddTaskPage();
                    }),
                  ),
              icon: const Icon(
                Icons.add,
                color: reNestGreyDarker,
              ))
        ],
      ),
      body: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: reNestWhite,
      padding: const EdgeInsets.only(top: bigPadding),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: FakeTextfield(),
            ),
            const SizedBox(
              height: bigPadding,
            ),
            const TabBar(tabs: [Tab(text: tasks), Tab(text: completed)]),
            Expanded(
                child: TabBarView(children: [
              Container(
                color: reNestAccentWhite,
                child: const TaskTab(),
              ),
              Container(
                color: reNestAccentWhite,
                child: const Center(
                  child: Text('Todo'),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
