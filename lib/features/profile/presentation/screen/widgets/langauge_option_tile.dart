import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/localization/cubit/locale_cubit.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class LanguageOptionTile extends StatelessWidget {
  final String title;
  final String code;
  final String currentLanguage;

  const LanguageOptionTile({
    super.key,
    required this.title,
    required this.code,
    required this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: AppText(title, style: font14w400),
      value: code,
      groupValue: currentLanguage,
      activeColor: const Color(0xff134FA2),
      onChanged: (String? value) {
        if (value != null) {
          context.read<LocaleCubit>().changeLanguage(value);
          GoRouter.of(context).pop(context);
        }
      },
    );
  }
}
