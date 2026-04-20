import 'package:flutter/material.dart';
import 'package:tourismapp/features/helper/presentation/screens/widgets/helper_screen_body.dart';

class HelperScreen extends StatelessWidget {
  const HelperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF9EE),
      body: const HelperScreenBody(),
    );
  }
}
