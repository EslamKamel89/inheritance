import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/extensions/context-extensions.dart';
import 'package:inheritance/core/router/app_routes_names.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/core/widgets/main_scaffold.dart';
import 'package:inheritance/utils/assets/assets.dart';

class AskUsScreen extends StatefulWidget {
  const AskUsScreen({super.key});

  @override
  State<AskUsScreen> createState() => _AskUsScreenState();
}

class _AskUsScreenState extends State<AskUsScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final questionController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    questionController.dispose();
    super.dispose();
  }

  Future _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: context.primaryColor,
            title: Text("ask_us_success_title".t(), style: TextStyle(color: Colors.white)),
            content: Text("ask_us_success_message".t(), style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
    Navigator.pushNamedAndRemoveUntil(context, AppRoutesNames.inheritanceScreen, (_) => false);
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "ask_us_validation_required".t();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    context.locale;

    return MainScaffold(
      appBarTitle: "ask_us_title".t(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.primaryColor.withOpacity(0.08),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.15, 1.15),
                        duration: 1600.ms,
                        curve: Curves.easeInOut,
                      )
                      .fadeOut(duration: 1600.ms, curve: Curves.easeInOut),

                  Image.asset(AssetsData.logo, width: 150, height: 150)
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(
                        begin: const Offset(0.85, 0.85),
                        end: const Offset(1, 1),
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      )
                      .shimmer(
                        duration: 1400.ms,
                        delay: 300.ms,
                        colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.05)],
                      ),
                ],
              ),

              const SizedBox(height: 18),
              TextFormField(
                controller: nameController,
                validator: _requiredValidator,
                decoration: _decoration("ask_us_name".t()),
              ).animate().fadeIn(),

              const SizedBox(height: 20),

              TextFormField(
                controller: mobileController,
                validator: _requiredValidator,
                keyboardType: TextInputType.phone,
                decoration: _decoration("ask_us_mobile".t(), hint: "ask_us_mobile_placeholder".t()),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 20),

              TextFormField(
                controller: emailController,
                validator: _requiredValidator,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration("ask_us_email".t()),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 20),

              TextFormField(
                controller: questionController,
                validator: _requiredValidator,
                minLines: 5,
                maxLines: 100,
                decoration: _decoration("ask_us_question".t()),
              ).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    "ask_us_submit".t(),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms).scale(),
            ],
          ),
        ),
      ),
    );
  }
}
