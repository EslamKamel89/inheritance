import 'package:flutter/material.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/utils/styles/styles.dart';

class InheritanceScreen extends StatefulWidget {
  const InheritanceScreen({super.key});

  @override
  State<InheritanceScreen> createState() => _InheritanceScreenState();
}

class _InheritanceScreenState extends State<InheritanceScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: "Bismillah, Let's Begin",
      child: SingleChildScrollView(child: Column(children: [
        
      ],)),
    );
  }
}

class InheritanceTextInputWidget extends StatefulWidget {
  const InheritanceTextInputWidget({
    super.key,
    required this.image,
    this.label,
    required this.updateInput,
    this.handleSubmit,
    this.handleBack,
    this.backTitle,
    this.nextTitle,
  });
  final String? image;
  final String? label;
  final void Function(String val) updateInput;
  final void Function()? handleSubmit;
  final void Function()? handleBack;
  final String? backTitle;
  final String? nextTitle;
  @override
  State<InheritanceTextInputWidget> createState() => _InheritanceTextInputWidgetState();
}

class _InheritanceTextInputWidgetState extends State<InheritanceTextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null) txt(widget.label!, e: St.bold20),
        TextFormField(),
        Row(
          children: [
            if (widget.handleBack != null)
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(color: context.primaryColor),
                  child: txt('Back'),
                ),
              ),
            if (widget.handleSubmit != null)
              InkWell(
                child: Container(
                  decoration: BoxDecoration(color: context.primaryColor),
                  child: txt('Next'),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
