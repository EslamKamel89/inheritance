import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class BrothersCountWidget extends StatefulWidget {
  const BrothersCountWidget({super.key});

  @override
  State<BrothersCountWidget> createState() => _BrothersCountWidgetState();
}

class _BrothersCountWidgetState extends State<BrothersCountWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.brothersCount = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.brothersCount ||
            current.currentStep == InheritanceEnum.brothersCount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.brothersCount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.brothers,
                handleSubmit: (String val) {
                  if (val.isEmpty) {
                    showSnackbar('Error', 'Please Enter Brothers Count', true);
                    return;
                  }
                  state.brothersCount = int.parse(val);
                  controller.changeStep(InheritanceEnum.result);
                },
                handleBack: () {
                  state.brothersCount = null;
                  controller.changeStep(InheritanceEnum.isBrothers);
                },
                label: 'How many brother(s) of the deceased?',
                placeholder: 'brother(s) count',
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
