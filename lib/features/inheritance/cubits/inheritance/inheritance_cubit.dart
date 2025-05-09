import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/heleprs/print_helper.dart';
import 'package:inheritance/features/inheritance/enums/gender_enum.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/enums/relations_enum.dart';

part 'inheritance_state.dart';

class InheritanceCubit extends Cubit<InheritanceState> {
  InheritanceCubit() : super(InheritanceState(currentStep: InheritanceEnum.totalAmount));
  void changeStep(InheritanceEnum step) {
    emit(state.copyWith(currentStep: step));
    pr(state, 'InheritanceState');
  }

  void reset() {
    emit(InheritanceState(currentStep: InheritanceEnum.totalAmount));
  }
}
