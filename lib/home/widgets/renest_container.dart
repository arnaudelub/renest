import 'package:flutter/material.dart';
import 'package:renest/style/colors.dart';

class ReNestContainer extends StatelessWidget {
  const ReNestContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [reNestBackgroundStart, reNestBackgroundEnd])),
      child: child,
    );
  }
}
