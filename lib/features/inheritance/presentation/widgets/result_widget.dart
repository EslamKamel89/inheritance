import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/enums/response_type.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/models/api_response_model.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/themes/themedata.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/cubits/result/result_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/models/result_model.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/back_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/default_animation.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/next_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/result_data_widget.dart';

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
                      CustomNextButton(
                        onTap: () {
                          controller.reset();
                        },
                        title: "start_again".t(),
                      ),
                      Sizer(),
                      CustomBackButton(
                        onTap: () {
                          if (state.brothersCount != null) {
                            controller.changeStep(InheritanceEnum.brothersCount);
                          } else {
                            controller.changeStep(InheritanceEnum.isBrothers);
                          }
                        },
                      ),
                    ],
                  ),
                  Sizer(),
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
          return ResultDataWidget(data: state.data?.data ?? {}, palette: lightClr);
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
}
