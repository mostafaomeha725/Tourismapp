import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/enums/app_enums.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_snack_bar.dart';
import 'package:tourismapp/features/auth/presentation/cubit/update_profile_cubit.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/editable_text_field.dart';

class EditProfileScreenBody extends StatefulWidget {
  const EditProfileScreenBody({super.key});

  @override
  State<EditProfileScreenBody> createState() => _EditProfileScreenBodyState();
}

class _EditProfileScreenBodyState extends State<EditProfileScreenBody> {
  bool _isNameEditable = false;
  bool _isEmailEditable = false;
  bool _isPhoneEditable = false;
  // bool _isLocationEditable = false;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmationFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  bool _isPasswordEditable = false;
  bool _isPasswordConfirmationEditable = false;
  // final FocusNode _locationFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    final prefs = sl<PreferencesStorage>();
    _nameController.text = prefs.getString(key: PreferencesKeys.name) ?? '';
    _emailController.text = prefs.getString(key: PreferencesKeys.email) ?? '';
    _phoneController.text = prefs.getString(key: PreferencesKeys.phone) ?? '';
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _passwordConfirmationFocus.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    // _locationFocus.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  String _normalizePhone(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _normalizePhone(_phoneController.text.trim());
    final password = _passwordController.text.trim();
    final passwordConfirmation = _passwordConfirmationController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: 'Name, email and phone are required',
      );
      return;
    }

    if (!_isValidEmail(email)) {
      CustomSnackBar.showError(context, message: 'Please enter a valid email');
      return;
    }

    if (password.isNotEmpty || passwordConfirmation.isNotEmpty) {
      if (password.length < 8) {
        CustomSnackBar.showError(
          context,
          message: 'Password must be at least 8 characters',
        );
        return;
      }

      if (password != passwordConfirmation) {
        CustomSnackBar.showError(
          context,
          message: 'Password confirmation does not match',
        );
        return;
      }
    }

    context.read<UpdateProfileCubit>().updateProfile(
      name: name,
      email: email,
      phone: phone,
      password: password.isEmpty ? null : password,
      passwordConfirmation: passwordConfirmation.isEmpty
          ? null
          : passwordConfirmation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          setState(() {
            _isNameEditable = false;
            _isEmailEditable = false;
            _isPhoneEditable = false;
            _isPasswordEditable = false;
            _isPasswordConfirmationEditable = false;
            _passwordController.clear();
            _passwordConfirmationController.clear();
            _nameController.text = state.result.client.name;
            _emailController.text = state.result.client.email;
            _phoneController.text = state.result.client.phone;
          });

          final prefs = sl<PreferencesStorage>();
          prefs.putString(
            key: PreferencesKeys.name,
            value: state.result.client.name,
          );
          prefs.putString(
            key: PreferencesKeys.email,
            value: state.result.client.email,
          );
          prefs.putString(
            key: PreferencesKeys.phone,
            value: state.result.client.phone,
          );

          CustomSnackBar.showSuccess(context, message: state.result.message);
        } else if (state is UpdateProfileFailure) {
          CustomSnackBar.showError(context, message: state.message);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              // EditableProfileImage(image: Assets.egyptsplash, onEditTap: () {}),
              SizedBox(height: 16.h),
              EditableTextField(
                label: 'Full Name',
                controller: _nameController,
                icon: Icons.person_outline,
                inputType: TextInputType.name,
                isEditable: _isNameEditable,
                focusNode: _nameFocus,
                onEditTap: () {
                  setState(() {
                    _isNameEditable = !_isNameEditable;
                    if (_isNameEditable) {
                      _nameFocus.requestFocus();
                    }
                  });
                },
              ),
              SizedBox(height: 16.h),
              EditableTextField(
                label: 'Email',
                controller: _emailController,
                icon: Icons.email_outlined,
                inputType: TextInputType.emailAddress,
                isEditable: _isEmailEditable,
                focusNode: _emailFocus,
                onEditTap: () {
                  setState(() {
                    _isEmailEditable = !_isEmailEditable;
                    if (_isEmailEditable) {
                      _emailFocus.requestFocus();
                    }
                  });
                },
              ),
              SizedBox(height: 16.h),
              EditableTextField(
                label: 'Phone Number',
                controller: _phoneController,
                icon: Icons.phone_outlined,
                inputType: TextInputType.phone,
                isEditable: _isPhoneEditable,
                focusNode: _phoneFocus,
                onEditTap: () {
                  setState(() {
                    _isPhoneEditable = !_isPhoneEditable;
                    if (_isPhoneEditable) {
                      _phoneFocus.requestFocus();
                    }
                  });
                },
              ),
              SizedBox(height: 16.h),
              EditableTextField(
                label: 'Password',
                controller: _passwordController,
                icon: Icons.lock_outline,
                inputType: TextInputType.visiblePassword,
                isEditable: _isPasswordEditable,
                focusNode: _passwordFocus,
                obscureText: true,
                placeholderText: '••••••••', // 👈 كده هيظهر نقط
                onEditTap: () {
                  setState(() {
                    _isPasswordEditable = !_isPasswordEditable;
                    if (_isPasswordEditable) {
                      _passwordFocus.requestFocus();
                    }
                  });
                },
              ),
              SizedBox(height: 16.h),
              EditableTextField(
                label: 'Confirm Password',
                controller: _passwordConfirmationController,
                icon: Icons.lock_clock_outlined,
                inputType: TextInputType.visiblePassword,
                isEditable: _isPasswordConfirmationEditable,
                focusNode: _passwordConfirmationFocus,
                obscureText: true,
                placeholderText: '••••••••',
                onEditTap: () {
                  setState(() {
                    _isPasswordConfirmationEditable =
                        !_isPasswordConfirmationEditable;
                    if (_isPasswordConfirmationEditable) {
                      _passwordConfirmationFocus.requestFocus();
                    }
                  });
                },
              ),
              SizedBox(height: 32.h),
              AppButton(
                text: state is UpdateProfileLoading
                    ? 'Updating...'
                    : 'Update Profile',
                color: const Color(0xFFdb6000),
                height: 50.h,
                textSize: 16.sp,
                onPressed: state is UpdateProfileLoading ? null : _submit,
              ),
            ],
          ),
        );
      },
    );
  }
}
