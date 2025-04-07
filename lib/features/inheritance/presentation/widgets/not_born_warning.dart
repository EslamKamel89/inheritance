import 'package:flutter/material.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/back_button.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/custom_image.dart';
import 'package:inheritance/features/inheritance/presentation/widgets/next_button.dart';
import 'package:inheritance/utils/assets/assets.dart';
import 'package:inheritance/utils/styles/styles.dart';

class NotBornWarningWidget extends StatelessWidget {
  const NotBornWarningWidget({super.key, required this.handleStartAgain, required this.handleBack});
  final VoidCallback handleBack;
  final VoidCallback handleStartAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Sizer(),
        CustomImage(image: AssetsData.unbornBaby),
        Sizer(),
        txt(
          "Please use the calculator once the baby is born (brought to the world).",
          e: St.bold20,
          c: Colors.red,
        ),
        Sizer(),
        Row(
          children: [
            CustomBackButton(onTap: handleBack),
            Sizer(),
            CustomNextButton(onTap: handleStartAgain, title: 'Start Again'),
          ],
        ),
      ],
    );
  }
}
