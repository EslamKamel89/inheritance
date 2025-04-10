import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class SonsCountWidget extends StatefulWidget {
  const SonsCountWidget({super.key});

  @override
  State<SonsCountWidget> createState() => _SonsCountWidgetState();
}

class _SonsCountWidgetState extends State<SonsCountWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.sonsCount = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.sonsCount ||
            current.currentStep == InheritanceEnum.sonsCount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.sonsCount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.sons,
                handleSubmit: (String val) {
                  if (val.isEmpty) {
                    showSnackbar('Error', 'Please Enter Sons Count', true);
                    return;
                  }
                  state.sonsCount = int.parse(val);
                  controller.changeStep(InheritanceEnum.daughersCount);
                },
                handleBack: () {
                  state.sonsCount = null;
                  controller.changeStep(InheritanceEnum.isChildren);
                },
                label: 'How many son(s) of the deceased?',
                placeholder: 'son(s) count',
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
