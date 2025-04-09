import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class SistersCountWidget extends StatefulWidget {
  const SistersCountWidget({super.key});

  @override
  State<SistersCountWidget> createState() => _SistersCountWidgetState();
}

class _SistersCountWidgetState extends State<SistersCountWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.sistersCount ||
            current.currentStep == InheritanceEnum.sistersCount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.sistersCount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.sisters,
                handleSubmit: (String val) {
                  if (val.isEmpty) {
                    showSnackbar('Error', 'Please Enter Sisters Count', true);
                    return;
                  }
                  state.sistersCount = int.parse(val);
                  controller.changeStep(InheritanceEnum.isBrothers);
                },
                handleBack: () {
                  state.sistersCount = null;
                  controller.changeStep(InheritanceEnum.isSisters);
                },
                label: 'How many sisters(s) of the deceased?',
                placeholder: 'sisters(s) count',
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
