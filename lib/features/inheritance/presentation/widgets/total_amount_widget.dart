import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_textinput_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class TotalAmountWidget extends StatefulWidget {
  const TotalAmountWidget({super.key});

  @override
  State<TotalAmountWidget> createState() => _TotalAmountWidgetState();
}

class _TotalAmountWidgetState extends State<TotalAmountWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.totalAmount ||
            current.currentStep == InheritanceEnum.totalAmount;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.totalAmount
            ? DefaultAnimation(
              child: InheritanceTextInputWidget(
                image: AssetsData.logo,
                handleSubmit: (String val) {
                  state.totalAmount = double.parse(val);
                  controller.changeStep(InheritanceEnum.isWasiyat);
                },
                // handleBack: () {},
                label: 'What is the total worth/amount left by deceased?',
                placeholder: 'total worth/amount',
                textInputType: TextInputType.number,
              ),
            )
            : SizedBox();
      },
    );
  }
}
