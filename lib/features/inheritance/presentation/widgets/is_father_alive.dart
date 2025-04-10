import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsFatherAliveWidget extends StatefulWidget {
  const IsFatherAliveWidget({super.key});

  @override
  State<IsFatherAliveWidget> createState() => _IsFatherAliveWidgetState();
}

class _IsFatherAliveWidgetState extends State<IsFatherAliveWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.isFatherAlive = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isFatherAlive ||
            current.currentStep == InheritanceEnum.isFatherAlive;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isFatherAlive
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.father,
                label: "Is the father of the deceased alive?",
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.isFatherAlive = answer;
                    controller.changeStep(InheritanceEnum.isMotherAlive);
                  });
                },
                handleBack: () {
                  state.isFatherAlive = null;
                  if (controller.state.maleDeceasedStatus != null) {
                    controller.changeStep(InheritanceEnum.maleDeceasedStatus);
                  } else if (controller.state.femaleDeceasedStatus != null) {
                    controller.changeStep(InheritanceEnum.femaleDeceasedStatus);
                  } else {
                    controller.changeStep(InheritanceEnum.yourRelation);
                  }
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
