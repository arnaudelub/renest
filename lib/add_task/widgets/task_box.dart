import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:renest/add_task/widgets/priority_box.dart';
import 'package:renest/style/style.dart';

class TaskBox extends StatefulWidget {
  const TaskBox({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  late Widget boxContent;
  bool isSelection = false;
  @override
  void initState() {
    boxContent = Text(widget.text);
    super.initState();
  }

  void _setSelectionContent() {
    final content = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PriorityBox(
            color: reNestRed,
            priority: Priority.high,
            task: widget.text,
            callback: _setNormalContent,
          ),
          const SizedBox(
            width: 5,
          ),
          PriorityBox(
              color: reNestGreen,
              priority: Priority.normal,
              task: widget.text,
              callback: _setNormalContent),
          const SizedBox(
            width: 5,
          ),
          PriorityBox(
              color: reNestBlue,
              priority: Priority.low,
              task: widget.text,
              callback: _setNormalContent)
        ]);
    setState(() {
      boxContent = content;
      isSelection = true;
    });
  }

  void _setNormalContent() {
    final content = Text(widget.text);
    setState(() {
      boxContent = content;
      isSelection = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: reNestAccentWhite,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: mediumPadding,
              right: mediumPadding / 2,
              top: isSelection ? 8 : smallPadding,
              bottom: isSelection ? 8 : smallPadding),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              boxContent,
              if (!isSelection) ...[
                IconButton(
                    onPressed: _setSelectionContent,
                    icon: const Icon(Icons.add))
              ] else ...[
                IconButton(
                    onPressed: _setNormalContent,
                    icon: const Icon(
                      Icons.close,
                      color: reNestGrey,
                    ))
              ],
            ],
          ),
        ));
  }
}
