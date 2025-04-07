import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/snackbar.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class LoanAmountWidget extends StatefulWidget {
  const LoanAmountWidget({super.key});

  @override
  State<LoanAmountWidget> createState() => _LoanAmountWidgetState();
}

class _LoanAmountWidgetState extends State<LoanAmountWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.loanAmount ||
            current.currentStep == InheritanceEnum.loanAmount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.loanAmount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.loan,
                handleSubmit: (String val) {
                  if (val.isEmpty) {
                    showSnackbar('Error', 'Please Enter Loan Amount', true);
                    return;
                  }
                  state.loanAmount = double.parse(val);
                  controller.changeStep(InheritanceEnum.isUnborn);
                },
                handleBack: () {
                  state.loanAmount = null;
                  controller.changeStep(InheritanceEnum.isLoan);
                },
                label:
                    'Please enter the total loan amount, to be returned on behalf of the deceased?',
                placeholder: 'total Loan amount” ',
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
