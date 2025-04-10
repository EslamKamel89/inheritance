import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/gender_enum.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_radio_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class DeceasedGenderWidget extends StatefulWidget {
  const DeceasedGenderWidget({super.key});

  @override
  State<DeceasedGenderWidget> createState() => _DeceasedGenderWidgetState();
}

class _DeceasedGenderWidgetState extends State<DeceasedGenderWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.deceasedGender = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.deceasedGender ||
            current.currentStep == InheritanceEnum.deceasedGender;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.deceasedGender
            ? DefaultAnimation(
              child: InheritanceRadioWidget<GenderEnum>(
                displayInRow: true,
                options: GenderEnum.values,
                image: AssetsData.husbandAndWife,
                label: "What is the gender of the deceased?",
                handleAnswer: (dynamic ans) {
                  final answer = ans as GenderEnum?;
                  if (answer == null) return;
                  Future.delayed(500.ms, () {
                    if (answer == GenderEnum.male) {
                      state.deceasedGender = answer;
                      controller.changeStep(InheritanceEnum.maleDeceasedStatus);
                    } else {
                      state.deceasedGender = answer;
                      controller.changeStep(InheritanceEnum.femaleDeceasedStatus);
                    }
                  });
                },
                handleBack: () {
                  state.deceasedGender = null;
                  controller.changeStep(InheritanceEnum.yourRelation);
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
