import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/globals.dart';
import 'package:inheritance/core/heleprs/print_helper.dart';
import 'package:inheritance/features/inheritance/cubits/result/result_cubit.dart';
import 'package:inheritance/features/inheritance/enums/gender_enum.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/enums/relations_enum.dart';
import 'package:inheritance/features/inheritance/models/grand_child_info_model.dart';

part 'inheritance_state.dart';

class InheritanceCubit extends Cubit<InheritanceState> {
  InheritanceCubit() : super(InheritanceState(currentStep: InheritanceEnum.totalAmount));
  void changeStep(InheritanceEnum step) {
    final newState = state.copyWith(currentStep: step);
    emit(newState);
    pr(newState, 'InheritanceState');
    if (step == InheritanceEnum.result) {
      final controller = resultController();
      if (controller == null) return;
      controller.fetchResult(newState);
    }
  }

  void reset() {
    emit(InheritanceState(currentStep: InheritanceEnum.totalAmount));
  }

  ResultCubit? resultController() {
    final context = navigatorKey.currentContext;
    if (context == null) return null;
    return context.read<ResultCubit>();
  }
}
