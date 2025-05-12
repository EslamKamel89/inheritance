import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/enums/response_type.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/heleprs/format_double.dart';
import 'package:inheritance/core/models/api_response_model.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/cubits/result/result_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/models/result_model.dart';
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
                  ResultTableWidget(),
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
}

class ResultTableWidget extends StatefulWidget {
  const ResultTableWidget({super.key});

  @override
  State<ResultTableWidget> createState() => _ResultTableWidgetState();
}

class _ResultTableWidgetState extends State<ResultTableWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ApiResponseModel<ResultModel>>(
      builder: (context, state) {
        if (state.response == ResponseEnum.success) {
          return Column(
            children: [
              _headerRow('Islamic Heir', "Amount", "Percent"),
              if (state.data?.totalAmount != null)
                _dataRow('Total Amount', state.data?.totalAmount, "5.00%"),
              if (state.data?.father != null) _dataRow('Father', state.data?.father, "5.00%"),
              if (state.data?.mother != null) _dataRow('Mother', state.data?.mother, "5.00%"),
              if (state.data?.husband != null) _dataRow('Husband', state.data?.husband, "5.00%"),
              if (state.data?.wife != null) _dataRow('Wife', state.data?.wife, "5.00%"),
              if (state.data?.sons != null) _dataRow('sons', state.data?.sons, "5.00%"),
              if (state.data?.son != null) _dataRow('son(each)', state.data?.son, "5.00%"),
              if (state.data?.daughters != null)
                _dataRow('Daughters', state.data?.daughters, "5.00%"),
              if (state.data?.daughter != null)
                _dataRow('Daughter(each)', state.data?.daughter, "5.00%"),
              if (state.data?.remaining != null)
                _dataRow('Remaining', state.data?.remaining, "5.00%"),
              // _dataRow('Brother(each)', "300", "5.00%"),
              // _dataRow('Sister(each)', "300", "5.00%"),
            ],
          );
        } else {
          return SizedBox(
            width: double.infinity,
            height: context.height * 0.5,
            child: Center(child: CircularProgressIndicator()),
          );
        }
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
          // Expanded(flex: 1, child: txt(percent, e: St.reg18)),
        ],
      ),
    );
  }

  Widget _dataRow(String title, double? amount, String? percent) {
    if (amount == null || percent == null) return SizedBox();
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4))),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: txt(title, e: St.bold16)),
          Expanded(flex: 1, child: txt(formatDouble(amount)?.toString() ?? '', e: St.reg16)),
          // Expanded(flex: 1, child: txt(percent, e: St.reg16)),
        ],
      ),
    );
  }
}
