import 'package:flutter/material.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/router/app_routes_names.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/default_screen_padding.dart';
import 'package:inheritance/core/widgets/language_selector.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    this.appBarTitle,
    required this.child,
    this.bottomNavigationBar,
    this.drawer,
    this.resizeToAvoidBottomInset,
    this.hideAppBar = false,
    this.floatingActionButton,
    this.titleWidget,
    this.backgroundColor,
  });
  final String? appBarTitle;
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final bool hideAppBar;
  final Widget? titleWidget;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    // final bool isDark = context.watch<ThemeCubit>().isDarkMode();
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: hideAppBar ? Colors.transparent : null,
          title: titleWidget ?? Text(appBarTitle ?? ''),
          foregroundColor: hideAppBar ? context.secondaryHeaderColor : null,
          actions: [
            LanguageSelector(),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(value: "about", child: Text("about_section_title".t())),
                  ],
              onSelected: (value) {
                if (value == "about") {
                  Navigator.pushNamed(context, AppRoutesNames.aboutScreen);
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        endDrawer: drawer,
        floatingActionButton: floatingActionButton,
        body: DefaultScreenPadding(child: child),
      ),
    );
  }
}
