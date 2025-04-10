import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/back_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/next_button.dart';
import 'package:inheritance/utils/styles/styles.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({super.key});

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.result ||
            current.currentStep == InheritanceEnum.result;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.result
            ? DefaultAnimation(
              child: Column(
                children: [
                  Sizer(),
                  _headerRow('Islamic Heir', "Amount", "Percent"),
                  _dataRow('Father', "300", "5.00%"),
                  _dataRow('Mother', "300", "5.00%"),
                  _dataRow('Husband', "300", "5.00%"),
                  _dataRow('Wife', "300", "5.00%"),
                  _dataRow('Daughter(each)', "300", "5.00%"),
                  _dataRow('son(each)', "300", "5.00%"),
                  _dataRow('Brother(each)', "300", "5.00%"),
                  _dataRow('Sister(each)', "300", "5.00%"),
                  Sizer(height: 30),
                  Row(
                    children: [
                      CustomBackButton(
                        onTap: () {
                          if (state.brothersCount != null) {
                            controller.changeStep(InheritanceEnum.brothersCount);
                          } else {
                            controller.changeStep(InheritanceEnum.isBrothers);
                          }
                        },
                      ),
                      Sizer(),
                      CustomNextButton(
                        onTap: () {
                          controller.reset();
                        },
                        title: 'Start Again',
                      ),
                    ],
                  ),
                ],
              ),
            )
            : SizedBox();
      },
    );
  }

  Widget _headerRow(String title, String amount, String percent) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey), top: BorderSide(color: Colors.grey)),
      ),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(flex: 2, child: txt(title, e: St.bold18)),
          Expanded(flex: 1, child: txt(amount, e: St.reg18)),
          Expanded(flex: 1, child: txt(percent, e: St.reg18)),
        ],
      ),
    );
  }

  Widget _dataRow(String title, String? amount, String? percent) {
    if (amount == null || percent == null) return SizedBox();
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4))),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: txt(title, e: St.bold16)),
          Expanded(flex: 1, child: txt(amount, e: St.reg16)),
          Expanded(flex: 1, child: txt(percent, e: St.reg16)),
        ],
      ),
    );
  }
}
