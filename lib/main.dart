import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:renest/core/app_config.dart';
import 'package:renest/home/cubit/cubit/tasks_cubit.dart';
import 'package:renest/home/view/home_page.dart';
import 'package:renest/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = Storage(await SharedPreferences.getInstance());
  storage.init();
  final configuredApp = AppConfig(storage: storage, child: const ReNest());
  runApp(configuredApp);
}

class ReNest extends StatelessWidget {
  const ReNest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = AppConfig.of(context)!.storage;
    return BlocProvider(
      create: (context) => TasksCubit(storage)..getPrioritizedTasks(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: reNestAccentWhite,
          brightness: Brightness.light,
          fontFamily: 'Avenir',
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Avenir',
                  fontSize: 34,
                  letterSpacing: .5,
                  color: Color(0xFF32315C)),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0),
          tabBarTheme: TabBarTheme(
            labelColor: reNestGrey,
            labelStyle: const TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w700,
                fontSize: 18),
            unselectedLabelColor: reNestGrey.withOpacity(.3),
            unselectedLabelStyle: const TextStyle(
                fontFamily: 'Avenir', fontWeight: FontWeight.w700),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.black),
              insets: EdgeInsets.symmetric(horizontal: bigPadding * 2),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
