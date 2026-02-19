import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/gender_enum.dart';
import 'package:inheritance/features/inheritance/enums/relations_enum.dart';
import 'package:inheritance/utils/assets/assets.dart';
import 'package:inheritance/utils/styles/styles.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InheritanceCubit>();
    final state = controller.state;

    return _decoratedContainer(
      child: SingleChildScrollView(child: Column(children: widgets(state))),
    );
  }

  List<Widget> widgets(InheritanceState state) {
    List<Widget> result = [];
    int i = 0;
    if (state.totalAmount != null) {
      result.add(
        _progressItem("total_amount".t(), state.totalAmount?.toString(), AssetsData.logo, i++),
      );
    } else {
      result.add(_initalStep());
    }
    if (state.isWasiyat == true && state.wasiyatAmount != null) {
      result.add(
        _progressItem(
          "wasiyat_amount".t(),
          state.wasiyatAmount?.toString(),
          AssetsData.contract,
          i++,
        ),
      );
    }
    if (state.isLoan == true && state.loanAmount != null) {
      result.add(
        _progressItem("loan_amount".t(), state.loanAmount?.toString(), AssetsData.loan, i++),
      );
    }
    if (state.yourRelation != null) {
      result.add(
        _progressItem(
          "relation_deceased".t(),
          state.yourRelation != Relation.none
              ? state.yourRelation?.display.t()
              : "none_of_them".t(),
          AssetsData.husbandAndWife,
          i++,
          isColumn: true,
        ),
      );
    }
    if (state.deceasedGender != null) {
      result.add(
        _progressItem(
          "deceased_gender".t(),
          state.deceasedGender?.display,
          state.deceasedGender == GenderEnum.male ? AssetsData.husband : AssetsData.wife,
          i++,
          isColumn: true,
        ),
      );
    }
    if (state.maleDeceasedStatus != null) {
      result.add(
        _progressItem(
          "wife_alive".t(),
          state.maleDeceasedStatus == true ? "yes".t() : "no".t(),
          AssetsData.wife,
          i++,
        ),
      );
    }
    if (state.femaleDeceasedStatus != null) {
      result.add(
        _progressItem(
          "husband_alive".t(),
          state.maleDeceasedStatus == true ? "yes".t() : "no".t(),
          AssetsData.husband,
          i++,
        ),
      );
    }
    if (state.isFatherAlive != null) {
      result.add(
        _progressItem(
          "father_alive".t(),
          state.isFatherAlive == true ? "yes".t() : "no".t(),
          AssetsData.father,
          i++,
        ),
      );
    }
    if (state.isMotherAlive != null) {
      result.add(
        _progressItem(
          "mother_alive".t(),
          state.isMotherAlive == true ? "yes".t() : "no".t(),
          AssetsData.mother,
          i++,
        ),
      );
    }
    if (state.isChildren == false) {
      result.add(_progressItem("children_exist".t(), 'no'.t(), AssetsData.children, i++));
    }
    if (state.sonsCount != null) {
      result.add(
        _progressItem("sons_count".t(), state.sonsCount?.toString(), AssetsData.sons, i++),
      );
    }
    if (state.daughtersCount != null) {
      result.add(
        _progressItem(
          "daughters_count".t(),
          state.daughtersCount?.toString(),
          AssetsData.daughter,
          i++,
        ),
      );
    }
    if (state.isSisters == false) {
      result.add(_progressItem("sisters_exist".t(), 'no'.t(), AssetsData.sisters, i++));
    }
    if (state.sistersCount != null) {
      result.add(
        _progressItem("sisters_count".t(), state.sistersCount?.toString(), AssetsData.sisters, i++),
      );
    }
    if (state.isBrothers == false) {
      result.add(_progressItem("brothers_exist".t(), 'no'.t(), AssetsData.brothers, i++));
    }
    if (state.sistersCount != null) {
      result.add(
        _progressItem(
          "brothers_count".t(),
          state.brothersCount?.toString(),
          AssetsData.brothers,
          i++,
        ),
      );
    }
    result.add(SizedBox(height: 50));
    return result;
  }

  Widget _initalStep() {
    return Container(
      height: 100.h,
      alignment: Alignment.center,
      child: txt(
        "total_amount_question".t(),
        e: St.bold18,
        textAlign: TextAlign.center,
        c: Colors.white,
      ),
    );
  }

  Widget _progressItem(
    String title,
    String? value,
    String imagePath,
    int i, {
    bool isColumn = false,
  }) {
    if (value == null) return SizedBox();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: isColumn ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(),
                width: 50,
                height: 60,
                child: Image.asset(imagePath, fit: BoxFit.fitHeight),
              ),
              Sizer(),
              if (!isColumn) txt(title, c: Colors.white, e: St.bold14),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isColumn) txt(title, c: Colors.white, e: St.bold14),
              if (isColumn) Sizer(),
              txt(value, c: Colors.white),
            ],
          ),
        ],
      ),
    ).animate().moveX(delay: (300 * i).ms, duration: 500.ms, begin: -500, end: 0);
  }

  Widget _decoratedContainer({required Widget child}) {
    return Container(
      height: 500.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: context.primaryColorDark.withOpacity(0.8),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: child,
    );
  }
}
