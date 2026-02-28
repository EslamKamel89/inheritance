import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/router/app_routes_names.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/default_screen_padding.dart';
import 'package:inheritance/core/widgets/language_selector.dart';

// import 'package:share_plus/share_plus.dart';
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
                    PopupMenuItem(value: "examples", child: Text("examples_title".t())),
                    PopupMenuItem(value: "share", child: Text("share_app".t())),
                  ],
              onSelected: (value) {
                if (value == "about") {
                  Navigator.pushNamed(context, AppRoutesNames.aboutScreen);
                }
                if (value == "examples") {
                  Navigator.pushNamed(context, AppRoutesNames.examplesScreen);
                }
                if (value == "share") {
                  _showShareModal(context);
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

  void _showShareModal(BuildContext context) {
    final primary = context.primaryColor;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "share_app_title".t(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ).animate().fadeIn(),

              const SizedBox(height: 10),

              Text(
                "share_app_body".t(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 25),

              _shareButton(
                context,
                icon: Icons.android,
                color: Colors.green,
                label: "share_android".t(),
                link: "https://play.google.com/store/apps/details?id=com.example.mirath",
              ),

              const SizedBox(height: 15),

              _shareButton(
                context,
                icon: Icons.apple,
                color: Colors.black,
                label: "share_ios".t(),
                link: "https://apps.apple.com/app/id0000000000",
              ),

              const SizedBox(height: 15),

              TextButton(onPressed: () => Navigator.pop(context), child: Text("cancel".t())),
            ],
          ),
        );
      },
    );
  }

  Widget _shareButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required String link,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        // await Share.share(link);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color.withOpacity(0.1),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.3);
  }
}
