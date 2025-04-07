import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/not_born_warning.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsUnbornWidget extends StatefulWidget {
  const IsUnbornWidget({super.key});

  @override
  State<IsUnbornWidget> createState() => _IsUnbornWidgetState();
}

class _IsUnbornWidgetState extends State<IsUnbornWidget> {
  bool showWarning = false;
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isUnborn ||
            current.currentStep == InheritanceEnum.isUnborn;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isUnborn && !showWarning
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.unbornBaby,
                label: "Is there any Unborn Baby of the deceased?",
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    if (answer) {
                      state.isUnborn = true;
                      setState(() {
                        showWarning = true;
                      });
                      // controller.changeStep(InheritanceEnum.wasiyatAmount);
                    } else {
                      state.isUnborn = false;
                      controller.changeStep(InheritanceEnum.yourRelation);
                    }
                  });
                },
                handleBack: () {
                  state.isUnborn = null;
                  if (state.loanAmount != null) {
                    controller.changeStep(InheritanceEnum.loanAmount);
                  } else {
                    controller.changeStep(InheritanceEnum.isLoan);
                  }
                },
              ),
            )
            : controller.state.currentStep == InheritanceEnum.isUnborn && showWarning
            ? DefaultAnimation(
              child: NotBornWarningWidget(
                handleBack: () {
                  state.isUnborn = null;
                  setState(() {
                    showWarning = false;
                  });
                },
                handleStartAgain: () {
                  showWarning = false;
                  controller.reset();
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
