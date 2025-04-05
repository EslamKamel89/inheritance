import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
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
    final controller = context.watch<InheritanceCubit>();
    return controller.state.currentStep == InheritanceEnum.totalAmount
        ? InheritanceTextInputWidget(
          image: AssetsData.logo,
          handleSubmit: (String val) {},
          handleBack: () {},
          label: 'What is the total worth/amount left by deceased?',
          placeholder: 'total worth/amount',
          textInputType: TextInputType.number,
        )
        : SizedBox();
  }
}
