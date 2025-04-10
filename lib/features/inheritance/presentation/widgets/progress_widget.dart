import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/widgets/sizer.dart';
import 'package:inheritance/features/inheritance/cubits/inheritance/inheritance_cubit.dart';
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
    if (state.totalAmount != null) {
      result.add(_progressItem('Total worth?', state.totalAmount?.toString(), AssetsData.logo));
    } else {
      result.add(
        Container(
          height: 200.h,
          alignment: Alignment.center,
          child: txt(
            'Please Enter total worth/amount left by deceased?',
            e: St.bold18,
            textAlign: TextAlign.center,
            c: Colors.white,
          ),
        ),
      );
    }
    return result;
  }

  Widget _progressItem(String title, String? value, String imagePath) {
    if (value == null) return SizedBox();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: context.primaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(),
                height: 50,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              Sizer(),
              txt(title, c: Colors.white, e: St.bold16),
            ],
          ),
          txt(value, c: Colors.white),
        ],
      ),
    );
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
