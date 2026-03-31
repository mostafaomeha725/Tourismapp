import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/app_form_field.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/auth/presentation/cubit/login_cubit.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool obscurePassword = true;
  bool hasSubmitted = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (!hasSubmitted) {
      setState(() => hasSubmitted = true);
    }

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    context.read<LoginCubit>().login(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showLoading(status: 'Signing in...');
        } else if (state is LoginFailure) {
          showError(state.message);
        } else if (state is LoginSuccess) {
          showSuccess(
            state.result.message.isNotEmpty
                ? state.result.message
                : 'Login successful.',
          );
          GoRouter.of(context).pushReplacement(Routes.customNavBar);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 104.h),

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
                    autovalidateMode: hasSubmitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 6.h, left: 16.h),
                      child: Icon(Icons.email, size: 24.sp),
                    ),
                    radius: 22.r,
                    validator: (value) {
                      final email = (value ?? '').trim();
                      if (email.isEmpty) {
                        return 'Email is required';
                      }
                      if (!email.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 18.h),

                  AppFormField(
                    maxLines: 1,
                    controller: passwordcontroller,
                    hintText: 'Password',
                    autovalidateMode: hasSubmitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.h, right: 6.h),
                      child: const Icon(Icons.lock),
                    ),
                    obsecureText: obscurePassword,
                    radius: 22.r,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                    text: isLoading ? 'Please wait...' : 'Sign in',
                    color: const Color(0xffdb6000),
                    onPressed: isLoading ? null : _submitLogin,
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
            ),
          ),
        );
      },
    );
  }
}
