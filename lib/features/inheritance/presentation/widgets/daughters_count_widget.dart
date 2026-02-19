import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class DaughtersCountWidget extends StatefulWidget {
  const DaughtersCountWidget({super.key});

  @override
  State<DaughtersCountWidget> createState() => _DaughtersCountWidgetState();
}

class _DaughtersCountWidgetState extends State<DaughtersCountWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.daughtersCount = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.daughtersCount ||
            current.currentStep == InheritanceEnum.daughtersCount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.daughtersCount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.daughter,
                handleSubmit: (String val) {
                  if (val.isEmpty) {
                    showSnackbar('Error', "please_enter_daughters".t(), true);
                    return;
                  }
                  state.daughtersCount = int.parse(val);
                  controller.changeStep(InheritanceEnum.grandChildrenInfo);
                },
                handleBack: () {
                  state.daughtersCount = null;
                  controller.changeStep(InheritanceEnum.sonsCount);
                },
                label: "how_many_daughters".t(),
                placeholder: "daughters_placeholder".t(),
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
