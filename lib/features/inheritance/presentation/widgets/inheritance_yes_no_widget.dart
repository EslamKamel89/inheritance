import 'package:flutter/material.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/back_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/custom_image.dart';
import 'package:inheritance/utils/styles/styles.dart';

class InheritanceYesNoWidget extends StatefulWidget {
  const InheritanceYesNoWidget({
    super.key,
    required this.image,
    this.label,
    this.handleAnswer,
    this.handleBack,
    this.backTitle,
    this.nextTitle,
    this.displayInRow = true,
  });
  final String? image;
  final String? label;
  final void Function(bool)? handleAnswer;
  final void Function()? handleBack;
  final String? backTitle;
  final String? nextTitle;
  final bool displayInRow;
  @override
  State<InheritanceYesNoWidget> createState() => _InheritanceYesNoWidgetState();
}

class _InheritanceYesNoWidgetState extends State<InheritanceYesNoWidget> {
  bool? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Sizer(),
        if (widget.image != null) CustomImage(image: widget.image!),
        Sizer(),
        if (widget.label != null) txt(widget.label!, e: St.bold20),
        Sizer(),
        Builder(
          builder: (context) {
            var widgets = [
              ListTile(
                title: Text("yes".t()),
                leading: Radio<bool>(
                  value: true,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value ?? false;
                    });
                    if (widget.handleAnswer != null) widget.handleAnswer!(true);
                  },
                ),
              ),

              ListTile(
                title: Text("no".t()),
                leading: Radio<bool>(
                  value: false,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value ?? false;
                    });
                    if (widget.handleAnswer != null) widget.handleAnswer!(false);
                  },
                ),
              ),
            ];
            return widget.displayInRow
                ? Row(children: widgets.map((e) => Expanded(child: e)).toList())
                : Column(children: widgets);
          },
        ),
        if (widget.handleBack != null)
          CustomBackButton(onTap: widget.handleBack, title: widget.backTitle),
      ],
    );
  }
}
