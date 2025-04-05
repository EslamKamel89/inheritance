import 'package:flutter/material.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';

class InheritanceScreen extends StatefulWidget {
  const InheritanceScreen({super.key});

  @override
  State<InheritanceScreen> createState() => _InheritanceScreenState();
}

class _InheritanceScreenState extends State<InheritanceScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(appBarTitle: "Bismillah, Let's Begin", child: SizedBox());
  }
}
