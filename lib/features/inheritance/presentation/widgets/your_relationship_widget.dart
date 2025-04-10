import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/enums/relations_enum.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_radio_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class YourRelationshipWidget extends StatefulWidget {
  const YourRelationshipWidget({super.key});

  @override
  State<YourRelationshipWidget> createState() => _YourRelationshipWidgetState();
}

class _YourRelationshipWidgetState extends State<YourRelationshipWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.yourRelation = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.yourRelation ||
            current.currentStep == InheritanceEnum.yourRelation;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.yourRelation
            ? DefaultAnimation(
              child: InheritanceRadioWidget<Relation>(
                displayInRow: false,
                options: Relation.values,
                image: AssetsData.husbandAndWife,
                label: "What is your relation with the deceased?",
                handleAnswer: (dynamic ans) {
                  final answer = ans as Relation?;
                  if (answer == null) return;
                  Future.delayed(500.ms, () {
                    if (answer == Relation.husband || answer == Relation.wife) {
                      state.yourRelation = answer;
                      controller.changeStep(InheritanceEnum.isFatherAlive);
                    } else if (answer == Relation.none) {
                      state.yourRelation = answer;
                      controller.changeStep(InheritanceEnum.deceasedGender);
                    }
                  });
                },
                handleBack: () {
                  state.yourRelation = null;
                  controller.changeStep(InheritanceEnum.isUnborn);
                },
              ),
            )
            : SizedBox();
      },
    );
  }
}
