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

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 48.w),
      child: Column(
        children: [
          SizedBox(height: 36.h),

          AppAsset(assetName: Assets.logo, height: 180.h),
          SizedBox(height: 4.h),

          AppText(
            'Begin your journey',
            style: font20w700,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 26.h),

          AppFormField(
            controller: emailcontroller,
            hintText: 'Email Address',
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 6.h, left: 16.h),
              child: Icon(Icons.email, size: 24.sp),
            ),
            radius: 22.r,
          ),

          SizedBox(height: 18.h),

          AppFormField(
            maxLines: 1,
            controller: passwordcontroller,
            hintText: 'Password',
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.h, right: 6.h),
              child: const Icon(Icons.lock),
            ),
            obsecureText: obscurePassword,
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

          SizedBox(height: 22.h),

          AppButton(
            text: 'Sign in',
            color: Color(0xffdb6000),
            onPressed: () {
              AuthService.login();
              GoRouter.of(context).pushReplacement(Routes.customNavBar);
            },
            height: 50.h,
            radius: 22.r,
          ),

          SizedBox(height: 12.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                'Don’t have an account ?  ',
                style: font14w500.copyWith(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(Routes.registerScreen);
                },
                child: AppText(
                  'Register now',
                  style: font14w700.copyWith(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
