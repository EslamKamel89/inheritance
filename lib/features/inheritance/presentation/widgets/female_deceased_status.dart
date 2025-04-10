import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class FemaleDeceasedStatusWidget extends StatefulWidget {
  const FemaleDeceasedStatusWidget({super.key});

  @override
  State<FemaleDeceasedStatusWidget> createState() => _FemaleDeceasedStatusWidgetState();
}

class _FemaleDeceasedStatusWidgetState extends State<FemaleDeceasedStatusWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.femaleDeceasedStatus = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.femaleDeceasedStatus ||
            current.currentStep == InheritanceEnum.femaleDeceasedStatus;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.femaleDeceasedStatus
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.husband,
                label: "Was the deceased married? If so, her husband is alive?",
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.femaleDeceasedStatus = answer;
                    controller.changeStep(InheritanceEnum.isFatherAlive);
                  });
                },
                handleBack: () {
                  state.femaleDeceasedStatus = null;
                  controller.changeStep(InheritanceEnum.deceasedGender);
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
