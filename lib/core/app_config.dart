import 'package:backend/backend.dart';
import 'package:flutter/widgets.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    Key? key,
    required this.storage,
    required Widget child,
  }) : super(key: key, child: child);

  final Storage storage;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
