import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsSistersWidget extends StatefulWidget {
  const IsSistersWidget({super.key});

  @override
  State<IsSistersWidget> createState() => _IsSistersWidgetState();
}

class _IsSistersWidgetState extends State<IsSistersWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.isSisters = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isSisters ||
            current.currentStep == InheritanceEnum.isSisters;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isSisters
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.sisters,
                label: "Does the deceased have any sister(s)",
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.isSisters = answer;
                    if (answer) {
                      controller.changeStep(InheritanceEnum.sistersCount);
                    } else {
                      controller.changeStep(InheritanceEnum.isBrothers);
                    }
                  });
                },
                handleBack: () {
                  state.isSisters = null;
                  if (state.daughtersCount != null) {
                    controller.changeStep(InheritanceEnum.daughtersCount);
                  } else {
                    controller.changeStep(InheritanceEnum.isChildren);
                  }
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
