import 'package:flutter/material.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/custom_image.dart';
import 'package:inheritance/utils/styles/styles.dart';

class InheritanceYesNoWidget extends StatefulWidget {
  const InheritanceYesNoWidget({
    super.key,
    required this.image,
    this.label,
    this.handleYes,
    this.handleNo,
    this.handleBack,
    this.backTitle,
    this.nextTitle,
  });
  final String? image;
  final String? label;
  final void Function()? handleYes;
  final void Function()? handleNo;
  final void Function()? handleBack;
  final String? backTitle;
  final String? nextTitle;
  @override
  State<InheritanceYesNoWidget> createState() => _InheritanceYesNoWidgetState();
}

class _InheritanceYesNoWidgetState extends State<InheritanceYesNoWidget> {
  bool selectedValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Sizer(),
        if (widget.image != null) CustomImage(image: widget.image!),
        Sizer(),
        if (widget.label != null) txt(widget.label!, e: St.bold20),
        Sizer(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('NO'),
                leading: Radio<bool>(
                  value: false,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value ?? false;
                    });
                  },
                ),
              ),
            ),
            // Second radio button
            Expanded(
              child: ListTile(
                title: Text('YES'),
                leading: Radio<bool>(
                  value: true,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value ?? false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
