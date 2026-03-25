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
import 'package:tourismapp/features/auth/presentation/cubit/register_cubit.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? errorMessage;
  bool hasSubmitted = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String _fullName() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    return '$firstName $lastName'.trim();
  }

  void _submitRegister() {
    if (!hasSubmitted) {
      setState(() => hasSubmitted = true);
    }

    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    final fullName = _fullName();

    context.read<RegisterCubit>().register(
      name: fullName,
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          showLoading(status: 'Creating account...');
        } else if (state is RegisterFailure) {
          showError(state.message);
        } else if (state is RegisterSuccess) {
          showSuccess(
            state.result.message.isNotEmpty
                ? state.result.message
                : 'Registration successful.',
          );
          GoRouter.of(context).pushReplacement(Routes.customNavBar);
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                          autovalidateMode: hasSubmitted
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.h, right: 6.h),
                            child: const Icon(Icons.person),
                          ),
                          radius: 22.r,
                          validator: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'First name is required';
                            }
                            return null;
                          },
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
                    controller: phoneController,
                    hintText: 'Phone Number',
                    autovalidateMode: hasSubmitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 6.h, left: 16.h),
                      child: const Icon(Icons.phone),
                    ),
                    radius: 22.r,
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 18.h),

                  AppFormField(
                    maxLines: 1,
                    controller: emailController,
                    hintText: 'Email Address',
                    autovalidateMode: hasSubmitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 6.h, left: 16.h),
                      child: const Icon(Icons.email),
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
                    controller: passwordController,
                    hintText: 'Password',
                    maxLines: 1,
                    autovalidateMode: hasSubmitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    obsecureText: obscurePassword,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.h, right: 6.h),
                      child: const Icon(Icons.lock),
                    ),
                    radius: 22.r,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Password is required';
                      }
                      if ((value ?? '').length < 6) {
                        return 'Password must be at least 6 characters';
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

                  SizedBox(height: 18.h),

                  AppFormField(
                    controller: confirmPasswordController,
                    hintText: 'Re-write password',
                    autovalidateMode: hasSubmitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    obsecureText: obscureConfirmPassword,
                    maxLines: 1,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.h, right: 6.h),
                      child: const Icon(Icons.lock),
                    ),
                    radius: 22.r,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Password confirmation is required';
                      }
                      if (value != passwordController.text) {
                        return 'Please make sure your passwords match';
                      }
                      return null;
                    },
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
                    text: isLoading ? 'Please wait...' : 'Sign up',
                    height: 50.h,
                    radius: 22.r,
                    color: const Color(0xffdb6000),
                    onPressed: isLoading ? null : _submitRegister,
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
          ),
        );
      },
    );
  }
}
