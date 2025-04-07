import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/inheritance_yes_no_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class IsWasiyatWidget extends StatefulWidget {
  const IsWasiyatWidget({super.key});

  @override
  State<IsWasiyatWidget> createState() => _IsWasiyatWidgetState();
}

class _IsWasiyatWidgetState extends State<IsWasiyatWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<InheritanceCubit>();
    return BlocBuilder<InheritanceCubit, InheritanceState>(
      buildWhen: (previous, current) {
        return previous.currentStep == InheritanceEnum.isWasiyat ||
            current.currentStep == InheritanceEnum.isWasiyat;
      },
      builder: (context, state) {
        return controller.state.currentStep == InheritanceEnum.isWasiyat
            ? InheritanceYesNoWidget(
              image: AssetsData.contract,
              label: "Is there any “WILL” or “Wasiyat” by the deceased?",
            )
            : SizedBox();
      },
    );
  }
}
