import 'package:flutter/material.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/utils/styles/styles.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap, this.title});
  final VoidCallback? onTap;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // margin: EdgeInsets.only(right: 40),
        decoration: BoxDecoration(
          color: context.secondaryHeaderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: txt(title ?? 'Back', e: St.bold20, c: Colors.white),
      ),
    );
  }
}
