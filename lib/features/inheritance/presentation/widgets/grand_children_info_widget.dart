import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/print_helper.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_grandchildren_input_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class GrandChildrenInfoWidget extends StatefulWidget {
  const GrandChildrenInfoWidget({super.key});

  @override
  State<GrandChildrenInfoWidget> createState() => _GrandChildrenInfoWidgetState();
}

class _GrandChildrenInfoWidgetState extends State<GrandChildrenInfoWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.grandChildrenInfo ||
            current.currentStep == InheritanceEnum.grandChildrenInfo;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.grandChildrenInfo
            ? DefaultAnimation(
              child: InheritanceGrandChildrenInputWidget(
                image: AssetsData.grandchildren,
                handleSubmit: () {
                  pr(controller.state.grandChildrenInfo, 'grandChildrenInfo');
                  controller.changeStep(InheritanceEnum.isSisters);
                },
                handleBack: () {
                  state.grandChildrenInfo = null;
                  if (state.daughtersCount != null) {
                    controller.changeStep(InheritanceEnum.daughtersCount);
                  } else {
                    controller.changeStep(InheritanceEnum.isChildren);
                  }
                },
                label: "how_many_grandchildren".t(),
                placeholder: "grandchildren_placeholder".t(),
              ),
            )
            : SizedBox();
      },
    );
  }
}
