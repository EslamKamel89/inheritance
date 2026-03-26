import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsDaughtersWidget extends StatefulWidget {
  const IsDaughtersWidget({super.key});

  @override
  State<IsDaughtersWidget> createState() => _IsDaughtersWidgetState();
}

class _IsDaughtersWidgetState extends State<IsDaughtersWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.isDaughters = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isDaughters ||
            current.currentStep == InheritanceEnum.isDaughters;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isDaughters
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.daughter,
                label: "does_have_daughters".t(),
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.isDaughters = answer;
                    if (answer) {
                      controller.changeStep(InheritanceEnum.daughtersCount);
                    } else {
                      state.daughtersCount = null;
                      if (state.isSons == true) {
                        controller.changeStep(InheritanceEnum.grandChildrenInfo);
                      } else {
                        controller.changeStep(InheritanceEnum.isSisters);
                      }
                    }
                  });
                },
                handleBack: () {
                  state.isDaughters = null;
                  if (state.isSons == true) {
                    controller.changeStep(InheritanceEnum.sonsCount);
                  } else {
                    controller.changeStep(InheritanceEnum.isSons);
                  }
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
