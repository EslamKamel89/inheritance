import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/appbar_title.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/brothers_count_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/daughters_count_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/deceassed_gender_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/female_deceased_status.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_brothers.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_children.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_father_alive.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_loan_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_mother_alive.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_sisters.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_unborn_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/is_wasiyat_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/loan_amount_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/male_deceased_status.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/sisters_count_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/sons_count_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/total_amount_widget.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/wasiyat_amount.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/your_relationship_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';

class InheritanceScreen extends StatelessWidget {
  const InheritanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: context.width, height: context.height, color: Colors.white),
        Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(image: AssetImage(AssetsData.background), fit: BoxFit.fill),
              ),
            )
            .animate(onPlay: (c) => c.repeat())
            .moveY(duration: 50000.ms, begin: -100, end: 100)
            .then()
            .moveY(duration: 50000.ms, begin: 100, end: -100)
            .then(),
        Container(
          width: context.width,
          height: context.height,
          color: Colors.white.withOpacity(0.5),
        ),
        MainScaffold(
          backgroundColor: Colors.transparent,
          titleWidget: AppBarTitle(),
          floatingActionButton: Material(
            borderRadius: BorderRadius.circular(70),
            elevation: 3,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(AssetsData.star2),
            ).animate(onPlay: (c) => c.repeat()).rotate(duration: 5000.ms, begin: 0, end: 1),
          ),
          child: SingleChildScrollView(child: InheritanceContent()),
        ),
      ],
    );
  }
}

class InheritanceContent extends StatelessWidget {
  const InheritanceContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TotalAmountWidget(),
        IsWasiyatWidget(),
        WasiyatAmountWidget(),
        IsLoanWidget(),
        LoanAmountWidget(),
        IsUnbornWidget(),
        YourRelationshipWidget(),
        IsFatherAliveWidget(),
        DeceasedGenderWidget(),
        MaleDeceasedStatusWidget(),
        FemaleDeceasedStatusWidget(),
        IsMotherAliveWidget(),
        IsChildrenWidget(),
        IsSistersWidget(),
        SonsCountWidget(),
        DaughtersCountWidget(),
        SistersCountWidget(),
        IsBrothersWidget(),
        BrothersCountWidget(),
      ],
    );
  }
}
