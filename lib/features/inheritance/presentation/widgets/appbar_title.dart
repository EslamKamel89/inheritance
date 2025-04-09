import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/utils/styles/styles.dart';

class AppBarTitle extends StatefulWidget {
  const AppBarTitle({super.key});

  @override
  State<AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InheritanceCubit>();
    String title = '';
    switch (controller.state.currentStep) {
      case InheritanceEnum.totalAmount:
        title = "Bismillah, Let's Begin";
        break;
      case InheritanceEnum.isWasiyat:
        title = "Any will written?";
        break;
      case InheritanceEnum.wasiyatAmount:
        title = "Will or Wasiyat amount?";
        break;
      case InheritanceEnum.isLoan:
        title = "Loan to settle?";
        break;
      case InheritanceEnum.loanAmount:
        title = "Loan Amount?";
        break;
      case InheritanceEnum.isUnborn:
        title = "Any unborn baby?";
        break;
      case InheritanceEnum.yourRelation:
        title = "Relation with deceased?";
        break;
      case InheritanceEnum.isFatherAlive:
        title = "Father still alive?";
        break;
      case InheritanceEnum.deceasedGender:
        title = "Deceased's gender?";
        break;
      case InheritanceEnum.maleDeceasedStatus:
        title = "Deceased's wife alive?";
        break;
      case InheritanceEnum.femaleDeceasedStatus:
        title = "Deceased's husband alive?";
        break;
      case InheritanceEnum.isMotherAlive:
        title = "Mother still alive?";
        break;
      case InheritanceEnum.isChildren:
        title = "Deceased's children?";
        break;
      case InheritanceEnum.isSisters:
        title = "Deceased's sisters?";
        break;
      case InheritanceEnum.sonsCount:
        title = "Sons count?";
        break;
      default:
    }
    return txt(title);
  }
}
