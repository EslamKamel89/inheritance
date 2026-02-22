import 'package:flutter/material.dart';
import 'package:inheritance/core/themes/themedata.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/back_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/custom_image.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/next_button.dart';
import 'package:inheritance/utils/styles/styles.dart';

class InheritanceTextInputWidget extends StatefulWidget {
  const InheritanceTextInputWidget({
    super.key,
    required this.image,
    this.label,
    this.onChanged,
    this.handleSubmit,
    this.handleBack,
    this.backTitle,
    this.nextTitle,
    this.placeholder,
    this.textInputType,
    this.fitImage = false,
  });
  final String? image;
  final String? label;
  final void Function(String)? onChanged;
  final void Function(String)? handleSubmit;
  final void Function()? handleBack;
  final String? backTitle;
  final String? nextTitle;
  final String? placeholder;
  final TextInputType? textInputType;
  final bool fitImage;
  @override
  State<InheritanceTextInputWidget> createState() => _InheritanceTextInputWidgetState();
}

class _InheritanceTextInputWidgetState extends State<InheritanceTextInputWidget> {
  final textController = TextEditingController();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Sizer(),
        if (widget.image != null) CustomImage(image: widget.image!, fitImage: widget.fitImage),
        if (widget.label != null) txt(widget.label!, e: St.bold20),
        Sizer(),
        TextFormField(
          controller: textController,
          onChanged: widget.onChanged,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: lightClr.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: lightClr.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: lightClr.primaryColorDark),
            ),
            labelStyle: TextStyle(color: Colors.black54, fontSize: 16),
            hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
          ),
        ),
        Sizer(height: 30),
        Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.handleBack != null)
                  CustomBackButton(onTap: widget.handleBack, title: widget.backTitle),
                Sizer(),
                if (widget.handleSubmit != null)
                  CustomNextButton(
                    onTap: () {
                      widget.handleSubmit!(textController.text);
                    },
                    title: widget.backTitle,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
