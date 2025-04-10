import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class MaleDeceasedStatusWidget extends StatefulWidget {
  const MaleDeceasedStatusWidget({super.key});

  @override
  State<MaleDeceasedStatusWidget> createState() => _MaleDeceasedStatusWidgetState();
}

class _MaleDeceasedStatusWidgetState extends State<MaleDeceasedStatusWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.maleDeceasedStatus = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.maleDeceasedStatus ||
            current.currentStep == InheritanceEnum.maleDeceasedStatus;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.maleDeceasedStatus
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.wife,
                label: "Was the deceased married? If so, his wife is alive?",
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.maleDeceasedStatus = answer;
                    controller.changeStep(InheritanceEnum.isFatherAlive);
                  });
                },
                handleBack: () {
                  state.maleDeceasedStatus = null;
                  controller.changeStep(InheritanceEnum.deceasedGender);
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
