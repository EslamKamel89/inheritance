import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsChildrenWidget extends StatefulWidget {
  const IsChildrenWidget({super.key});

  @override
  State<IsChildrenWidget> createState() => _IsChildrenWidgetState();
}

class _IsChildrenWidgetState extends State<IsChildrenWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isChildren ||
            current.currentStep == InheritanceEnum.isChildren;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isChildren
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.children,
                label: "Do the deceased have any children?",
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.isChildren = answer;
                    if (answer) {
                      controller.changeStep(InheritanceEnum.sonsCount);
                    } else {
                      controller.changeStep(InheritanceEnum.isSisters);
                    }
                  });
                },
                handleBack: () {
                  state.isChildren = null;
                  controller.changeStep(InheritanceEnum.isMotherAlive);
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
