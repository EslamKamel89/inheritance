import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/our_work/app_info_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCard extends StatefulWidget {
  final AppInfo app;

  const AppCard({super.key, required this.app});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  late final PageController _controller;
  late final Timer _timer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_controller.hasClients) {
        _currentPage = (_currentPage + 1) % widget.app.images.length;

        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: primary.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCarousel(),
          const SizedBox(height: 20),
          _buildTitle(),
          const SizedBox(height: 10),
          _buildDescription(),
          const SizedBox(height: 20),
          _buildButtons(),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildCarousel() {
    return SizedBox(
          height: context.height * 0.5,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.app.images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(widget.app.images[index], fit: BoxFit.fitHeight),
                    )
                    .animate()
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 500.ms),
              );
            },
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: -4, end: 4, duration: 4.seconds);
  }

  Widget _buildTitle() {
    return Text(
      widget.app.titleKey.t(),
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildDescription() {
    return Text(
      widget.app.descriptionKey.t(),
      style: const TextStyle(fontSize: 14, height: 1.6),
    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2);
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(child: _storeButton(title: "our_work_app_store".t(), url: widget.app.appStoreUrl)),
        const SizedBox(width: 12),
        Expanded(
          child: _storeButton(title: "our_work_google_play".t(), url: widget.app.googlePlayUrl),
        ),
      ],
    );
  }

  Widget _storeButton({required String title, required String url}) {
    final primary = context.primaryColor;

    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () async {
            final uri = Uri.parse(url);

            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          child: Text(title, style: const TextStyle(color: Colors.white)),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds);
  }
}
