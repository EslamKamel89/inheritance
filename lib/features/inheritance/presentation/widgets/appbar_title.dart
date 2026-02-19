import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
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
        title = "bismillah_begin".t();
        break;
      case InheritanceEnum.isWasiyat:
        title = "any_will_written".t();
        break;
      case InheritanceEnum.wasiyatAmount:
        title = "wasiyat_amount".t();
        break;
      case InheritanceEnum.isLoan:
        title = "loan_settle".t();
        break;
      case InheritanceEnum.loanAmount:
        title = "loan_amount".t();
        break;
      case InheritanceEnum.isUnborn:
        title = "any_unborn_baby".t();
        break;
      case InheritanceEnum.yourRelation:
        title = "relation_deceased".t();
        break;
      case InheritanceEnum.isFatherAlive:
        title = "father_alive".t();
        break;
      case InheritanceEnum.deceasedGender:
        title = "deceased_gender".t();
        break;
      case InheritanceEnum.maleDeceasedStatus:
        title = "wife_alive".t();
        break;
      case InheritanceEnum.femaleDeceasedStatus:
        title = "husband_alive".t();
        break;
      case InheritanceEnum.isMotherAlive:
        title = "mother_alive".t();
        break;
      case InheritanceEnum.isChildren:
        title = "children_exist".t();
        break;
      case InheritanceEnum.isSisters:
        title = "sisters_exist".t();
        break;
      case InheritanceEnum.sonsCount:
        title = "sons_count".t();
        break;
      case InheritanceEnum.daughtersCount:
        title = "daughters_count".t();
        break;
      case InheritanceEnum.sistersCount:
        title = "sisters_count".t();
        break;
      case InheritanceEnum.isBrothers:
        title = "brothers_exist".t();
        break;
      case InheritanceEnum.brothersCount:
        title = "brothers_count".t();
        break;
      case InheritanceEnum.result:
        title = "result".t();
        break;
      default:
    }
    return txt(title);
  }
}
