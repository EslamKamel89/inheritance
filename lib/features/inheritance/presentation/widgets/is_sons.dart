import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsSonsWidget extends StatefulWidget {
  const IsSonsWidget({super.key});

  @override
  State<IsSonsWidget> createState() => _IsSonsWidgetState();
}

class _IsSonsWidgetState extends State<IsSonsWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.isSons = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isSons ||
            current.currentStep == InheritanceEnum.isSons;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isSons
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.sons,
                label: "does_have_sons".t(),
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.isSons = answer;
                    if (answer) {
                      controller.changeStep(InheritanceEnum.sonsCount);
                    } else {
                      state.sonsCount = null;
                      controller.changeStep(InheritanceEnum.isDaughters);
                    }
                  });
                },
                handleBack: () {
                  state.isSons = null;
                  controller.changeStep(InheritanceEnum.isMotherAlive);
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
