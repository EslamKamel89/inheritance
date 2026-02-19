import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsMotherAliveWidget extends StatefulWidget {
  const IsMotherAliveWidget({super.key});

  @override
  State<IsMotherAliveWidget> createState() => _IsMotherAliveWidgetState();
}

class _IsMotherAliveWidgetState extends State<IsMotherAliveWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.isMotherAlive = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isMotherAlive ||
            current.currentStep == InheritanceEnum.isMotherAlive;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isMotherAlive
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.mother,
                label: "mother_alive_question".t(),
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.isMotherAlive = answer;
                    controller.changeStep(InheritanceEnum.isChildren);
                  });
                },
                handleBack: () {
                  state.isMotherAlive = null;
                  controller.changeStep(InheritanceEnum.isFatherAlive);
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
