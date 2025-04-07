import 'package:flutter/material.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/back_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/custom_image.dart';
import 'package:inheritance/utils/styles/styles.dart';

class InheritanceRadioWidget extends StatefulWidget {
  const InheritanceRadioWidget({
    super.key,
    required this.options,
    required this.image,
    this.label,
    this.handleAnswer,
    this.handleBack,
    this.backTitle,
    this.nextTitle,
    this.displayInRow = true,
  });
  final List<String> options;
  final String? image;
  final String? label;
  final void Function(String?)? handleAnswer;
  final void Function()? handleBack;
  final String? backTitle;
  final String? nextTitle;
  final bool displayInRow;
  @override
  State<InheritanceRadioWidget> createState() => _InheritanceRadioWidgetState();
}

class _InheritanceRadioWidgetState extends State<InheritanceRadioWidget> {
  String? selectedValue;
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
            var widgets =
                widget.options.map((e) {
                  return ListTile(
                    title: Text(e),
                    leading: Radio<String>(
                      value: e,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                        if (widget.handleAnswer != null) widget.handleAnswer!(value);
                      },
                    ),
                  );
                }).toList();
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
