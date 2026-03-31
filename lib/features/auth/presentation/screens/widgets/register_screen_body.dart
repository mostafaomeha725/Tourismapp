import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/auth/presentation/cubit/register_cubit.dart';
import 'package:tourismapp/features/auth/presentation/screens/widgets/register_form_fields.dart';

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

                  RegisterFormFields(
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    phoneController: phoneController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    hasSubmitted: hasSubmitted,
                    obscurePassword: obscurePassword,
                    obscureConfirmPassword: obscureConfirmPassword,
                    onTogglePassword: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    onToggleConfirmPassword: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
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
