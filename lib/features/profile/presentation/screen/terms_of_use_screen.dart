import 'package:flutter/material.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_appbar.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/terms_of_use_screen_body.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.termsOfUse),
      body: TermsOfUseScreenBody(),
    );
  }
}
