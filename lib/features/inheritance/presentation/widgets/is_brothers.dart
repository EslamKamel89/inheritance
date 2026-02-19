import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsBrothersWidget extends StatefulWidget {
  const IsBrothersWidget({super.key});

  @override
  State<IsBrothersWidget> createState() => _IsBrothersWidgetState();
}

class _IsBrothersWidgetState extends State<IsBrothersWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.isBrothers = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isBrothers ||
            current.currentStep == InheritanceEnum.isBrothers;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isBrothers
            ? DefaultAnimation(
              child: InheritanceYesNoWidget(
                image: AssetsData.brothers,
                label: "does_have_brothers".t(),
                handleAnswer: (bool answer) {
                  Future.delayed(500.ms, () {
                    state.isBrothers = answer;
                    if (answer) {
                      controller.changeStep(InheritanceEnum.brothersCount);
                    } else {
                      controller.changeStep(InheritanceEnum.result);
                    }
                  });
                },
                handleBack: () {
                  state.isBrothers = null;
                  if (state.sistersCount != null) {
                    controller.changeStep(InheritanceEnum.sistersCount);
                  } else {
                    controller.changeStep(InheritanceEnum.isSisters);
                  }
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
