import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsLoanWidget extends StatefulWidget {
  const IsLoanWidget({super.key});

  @override
  State<IsLoanWidget> createState() => _IsLoanWidgetState();
}

class _IsLoanWidgetState extends State<IsLoanWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isLoan ||
            current.currentStep == InheritanceEnum.isLoan;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isLoan
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.loan,
                label: "Is there any loan to be returned on behalf of the deceased?",
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    if (answer) {
                      state.isLoan = true;
                      controller.changeStep(InheritanceEnum.loanAmount);
                    } else {
                      state.isLoan = false;
                      controller.changeStep(InheritanceEnum.isUnborn);
                    }
                  });
                },
                handleBack: () {
                  state.isLoan = null;
                  if (state.wasiyatAmount != null) {
                    controller.changeStep(InheritanceEnum.wasiyatAmount);
                  } else {
                    controller.changeStep(InheritanceEnum.isWasiyat);
                  }
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
