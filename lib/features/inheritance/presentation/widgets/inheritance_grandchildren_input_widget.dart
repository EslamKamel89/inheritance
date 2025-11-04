import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/themes/themedata.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/gender_enum.dart';
import 'package:inheritance/features/inheritance/models/grand_child_info_model.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/back_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/custom_image.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/next_button.dart';
import 'package:inheritance/utils/styles/styles.dart';

class InheritanceGrandChildrenInputWidget extends StatefulWidget {
  const InheritanceGrandChildrenInputWidget({
    super.key,
    required this.image,
    required this.handleSubmit,
    required this.handleBack,
    this.label,
    this.backTitle,
    this.nextTitle,
    this.placeholder,
  });
  final String? image;
  final String? label;
  final void Function() handleSubmit;
  final void Function() handleBack;
  final String? backTitle;
  final String? nextTitle;
  final String? placeholder;
  @override
  State<InheritanceGrandChildrenInputWidget> createState() =>
      _InheritanceGrandChildrenInputWidgetState();
}

class _InheritanceGrandChildrenInputWidgetState extends State<InheritanceGrandChildrenInputWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    _initializeGrandChildrenData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final grandChildren = controller.state.grandChildrenInfo?.grandChildren;
    return Column(
      children: [
        Sizer(),
        if (widget.image != null) CustomImage(image: widget.image!),
        if (widget.label != null) txt(widget.label!, e: St.bold20),
        Sizer(),
        ...List.generate(grandChildren?.length ?? 0, (i) {
          return InheritanceGrandChildInputWidget(grandChild: grandChildren![i]);
        }),
        Sizer(height: 30),
        Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBackButton(onTap: widget.handleBack, title: widget.backTitle),
                Sizer(),
                CustomNextButton(
                  onTap: () {
                    widget.handleSubmit();
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

  void _initializeGrandChildrenData() {
    final state = controller.state;
    state.grandChildrenInfo = GrandChildrenInfoModel(grandChildren: []);
    for (var i = 0; i < (state.sonsCount ?? 0); i++) {
      state.grandChildrenInfo?.grandChildren.add(
        GrandChildInfoModel(
          gender: GenderEnum.male,
          status: 'alive',
          grandChildrenMalesCount: 0,
          grandChildrenFemalesCount: 0,
        ),
      );
    }
    for (var i = 0; i < (state.daughtersCount ?? 0); i++) {
      state.grandChildrenInfo?.grandChildren.add(
        GrandChildInfoModel(
          gender: GenderEnum.female,
          status: 'alive',
          grandChildrenMalesCount: 0,
          grandChildrenFemalesCount: 0,
        ),
      );
    }
    // pr(state.grandChildrenInfo, 'grandchildrenInfo');
  }
}

class InheritanceGrandChildInputWidget extends StatefulWidget {
  const InheritanceGrandChildInputWidget({super.key, required this.grandChild});
  final GrandChildInfoModel grandChild;
  @override
  State<InheritanceGrandChildInputWidget> createState() => _InheritanceGrandChildInputWidgetState();
}

class _InheritanceGrandChildInputWidgetState extends State<InheritanceGrandChildInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("gender: ${widget.grandChild.gender?.display}"),
        TextFormField(
          initialValue: '0',
          onChanged: (v) {
            widget.grandChild.grandChildrenMalesCount = int.parse(v);
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter grandchildren males count',
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
      ],
    );
  }
}
