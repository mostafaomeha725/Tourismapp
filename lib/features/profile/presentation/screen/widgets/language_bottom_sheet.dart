import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/langauge_option_tile.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguage = sl<PreferencesStorage>().getCurrentLanguage();
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(loc.language, style: font16w600),
          SizedBox(height: 16.h),
          LanguageOptionTile(
            title: loc.arabic,
            code: 'ar',
            currentLanguage: currentLanguage,
          ),
          LanguageOptionTile(
            title: loc.english,
            code: 'en',
            currentLanguage: currentLanguage,
          ),
          LanguageOptionTile(
            title: loc.french,
            code: 'fr',
            currentLanguage: currentLanguage,
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => const LanguageBottomSheet(),
    );
  }
}
