import 'package:flutter/material.dart';
import 'package:renest/core/constant.dart';
import 'package:renest/style/style.dart';

class FakeTextfield extends StatelessWidget {
  const FakeTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => debugPrint('Todo'),
      child: Container(
          decoration: const BoxDecoration(
              color: reNestAccentWhite,
              borderRadius:
                  BorderRadius.all(Radius.circular(halfRoundedRadius))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 1.5),
            child: Row(
              children: const [
                SizedBox(
                  width: largeSpacer,
                ),
                Icon(
                  Icons.search,
                  color: reNestGrey,
                ),
                SizedBox(width: smallPadding),
                Text(
                  search,
                  style: TextStyle(fontSize: 22, fontFamily: 'Avenir-book'),
                )
              ],
            ),
          )),
    );
  }
}
