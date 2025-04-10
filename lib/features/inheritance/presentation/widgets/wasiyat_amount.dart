import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class WasiyatAmountWidget extends StatefulWidget {
  const WasiyatAmountWidget({super.key});

  @override
  State<WasiyatAmountWidget> createState() => _WasiyatAmountWidgetState();
}

class _WasiyatAmountWidgetState extends State<WasiyatAmountWidget> {
  late final InheritanceCubit controller;
  @override
  void initState() {
    controller = context.read<InheritanceCubit>();
    controller.state.wasiyatAmount = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.wasiyatAmount ||
            current.currentStep == InheritanceEnum.wasiyatAmount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.wasiyatAmount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.contract,
                handleSubmit: (String val) {
                  if (val.isEmpty) {
                    showSnackbar('Error', 'Please Enter Wasiyat Amount', true);
                    return;
                  }
                  state.wasiyatAmount = double.parse(val);
                  controller.changeStep(InheritanceEnum.isLoan);
                },
                handleBack: () {
                  state.wasiyatAmount = null;
                  controller.changeStep(InheritanceEnum.isWasiyat);
                },
                label:
                    'Please enter the total amount mentioned on the WILL or Wasiyat by the deceased?',
                placeholder: 'total “WILL” or “Wasiyat” ',
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
