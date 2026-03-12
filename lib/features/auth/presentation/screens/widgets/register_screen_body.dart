import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/app_form_field.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? errorMessage;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 66.h),

            AppAsset(assetName: Assets.logo, height: 180.h),
            SizedBox(height: 4.h),

            AppText(
              'Begin your journey',
              style: font20w700,
              alignment: AlignmentDirectional.center,
            ),
            SizedBox(height: 26.h),

            Row(
              children: [
                Expanded(
                  child: AppFormField(
                    maxLines: 1,
                    controller: firstNameController,
                    hintText: 'First name',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.h, right: 6.h),
                      child: const Icon(Icons.person),
                    ),
                    radius: 22.r,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppFormField(
                    controller: lastNameController,
                    maxLines: 1,
                    hintText: 'Last name',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.h, right: 6.h),
                      child: const Icon(Icons.person),
                    ),
                    radius: 22.r,
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),

            AppFormField(
              maxLines: 1,
              controller: emailController,
              hintText: 'Email Address',
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 6.h, left: 16.h),
                child: const Icon(Icons.email),
              ),
              radius: 22.r,
            ),

            SizedBox(height: 18.h),

            AppFormField(
              controller: passwordController,
              hintText: 'Password',
              maxLines: 1,
              obsecureText: obscurePassword,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.h, right: 6.h),
                child: const Icon(Icons.lock),
              ),
              radius: 22.r,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  size: 22.sp,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
            ),

            SizedBox(height: 18.h),

            AppFormField(
              controller: confirmPasswordController,
              hintText: 'Re-write password',
              obsecureText: obscureConfirmPassword,
              maxLines: 1,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.h, right: 6.h),
                child: const Icon(Icons.lock),
              ),
              radius: 22.r,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 22.sp,
                ),
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
              ),
            ),

            if (errorMessage != null) ...[
              SizedBox(height: 6.h),
              AppText(
                errorMessage!,
                style: font12w400.copyWith(color: Colors.red),
              ),
            ],

            SizedBox(height: 24.h),

            AppButton(
              text: 'Sign up',
              height: 50.h,
              radius: 22.r,
              color: Color(0xffdb6000),

              onPressed: () {
                if (passwordController.text != confirmPasswordController.text) {
                  setState(() {
                    errorMessage = 'Please make sure your passwords match.';
                  });
                } else {
                  setState(() => errorMessage = null);
                  AuthService.login();
                  GoRouter.of(context).pushReplacement(Routes.customNavBar);
                }
              },
            ),

            SizedBox(height: 8.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  'Already have an account? ',
                  style: font14w500.copyWith(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () => GoRouter.of(context).pop(),
                  child: AppText(
                    'Sign in',
                    style: font14w700.copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
