import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
import 'package:inheritance/features/inheritance/enums/inheritance.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/total_amount_widget.dart';
import 'package:inheritance/utils/assets/assets.dart';
import 'package:inheritance/utils/styles/styles.dart';

class InheritanceScreen extends StatefulWidget {
  const InheritanceScreen({super.key});

  @override
  State<InheritanceScreen> createState() => _InheritanceScreenState();
}

class _InheritanceScreenState extends State<InheritanceScreen> {
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
            .moveY(duration: 10000.ms, begin: -30, end: 30)
            .then()
            .moveY(duration: 10000.ms, begin: 30, end: -30)
            .then(),
        Container(
          width: context.width,
          height: context.height,
          color: Colors.white.withOpacity(0.5),
        ),
        MainScaffold(
          backgroundColor: Colors.transparent,
          titleWidget: AppBarTitle(),
          child: SingleChildScrollView(child: Column(children: [TotalAmountWidget()])),
        ),
      ],
    );
  }
}

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
      default:
    }
    return txt(title);
  }
}
