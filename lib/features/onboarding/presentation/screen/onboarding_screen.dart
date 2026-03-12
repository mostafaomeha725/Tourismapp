import 'package:flutter/material.dart';
import 'package:tourismapp/features/onboarding/presentation/screen/widgets/onboarding_screen_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: OnboardingScreenBody());
  }
}
