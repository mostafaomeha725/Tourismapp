import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/widgets/app_form_field.dart';
import 'package:tourismapp/features/auth/presentation/screens/widgets/register_validators.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class RegisterFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool hasSubmitted;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  const RegisterFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.hasSubmitted,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
  });

  AutovalidateMode get _autoValidateMode => hasSubmitted
      ? AutovalidateMode.onUserInteraction
      : AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppFormField(
                maxLines: 1,
                controller: firstNameController,
                hintText: loc.firstName,
                autovalidateMode: _autoValidateMode,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.h, right: 6.h),
                  child: const Icon(Icons.person),
                ),
                radius: 22.r,
                validator: (value) => RegisterValidators.firstName(value, loc),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppFormField(
                controller: lastNameController,
                maxLines: 1,
                hintText: loc.lastName,
                autovalidateMode: _autoValidateMode,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.h, right: 6.h),
                  child: const Icon(Icons.person),
                ),
                radius: 22.r,
                validator: (value) => RegisterValidators.lastName(value, loc),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        AppFormField(
          maxLines: 1,
          controller: phoneController,
          hintText: loc.phoneNumber,
          autovalidateMode: _autoValidateMode,
          keyboardType: TextInputType.phone,
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 6.h, left: 16.h),
            child: const Icon(Icons.phone),
          ),
          radius: 22.r,
          validator: (value) => RegisterValidators.phone(value, loc),
        ),
        SizedBox(height: 18.h),
        AppFormField(
          maxLines: 1,
          controller: emailController,
          hintText: loc.emailAddress,
          autovalidateMode: _autoValidateMode,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 6.h, left: 16.h),
            child: const Icon(Icons.email),
          ),
          radius: 22.r,
          validator: (value) => RegisterValidators.email(value, loc),
        ),
        SizedBox(height: 18.h),
        AppFormField(
          controller: passwordController,
          hintText: loc.password,
          maxLines: 1,
          autovalidateMode: _autoValidateMode,
          obsecureText: obscurePassword,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.h, right: 6.h),
            child: const Icon(Icons.lock),
          ),
          radius: 22.r,
          validator: (value) => RegisterValidators.password(value, loc),
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off : Icons.visibility,
              size: 22.sp,
            ),
            onPressed: onTogglePassword,
          ),
        ),
        SizedBox(height: 18.h),
        AppFormField(
          controller: confirmPasswordController,
          hintText: loc.reWritePassword,
          autovalidateMode: _autoValidateMode,
          obsecureText: obscureConfirmPassword,
          maxLines: 1,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.h, right: 6.h),
            child: const Icon(Icons.lock),
          ),
          radius: 22.r,
          validator: (value) => RegisterValidators.confirmPassword(
            value,
            passwordController.text,
            loc,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
              size: 22.sp,
            ),
            onPressed: onToggleConfirmPassword,
          ),
        ),
      ],
    );
  }
}
