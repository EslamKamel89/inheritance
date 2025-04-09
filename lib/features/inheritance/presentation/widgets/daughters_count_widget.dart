import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class DaughtersCountWidget extends StatefulWidget {
  const DaughtersCountWidget({super.key});

  @override
  State<DaughtersCountWidget> createState() => _DaughtersCountWidgetState();
}

class _DaughtersCountWidgetState extends State<DaughtersCountWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.daughersCount ||
            current.currentStep == InheritanceEnum.daughersCount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.daughersCount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.daughter,
                handleSubmit: (String val) {
                  if (val.isEmpty) {
                    showSnackbar('Error', 'Please Enter Daughters Count', true);
                    return;
                  }
                  state.daughersCount = int.parse(val);
                  controller.changeStep(InheritanceEnum.isSisters);
                },
                handleBack: () {
                  state.daughersCount = null;
                  controller.changeStep(InheritanceEnum.sonsCount);
                },
                label: 'How many daughter(s) of the deceased?',
                placeholder: 'daughter(s) count',
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
