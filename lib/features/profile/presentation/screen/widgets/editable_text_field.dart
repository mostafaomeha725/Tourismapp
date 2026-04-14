import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class EditableTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final IconData icon;
  final TextInputType? inputType;
  final VoidCallback onEditTap;
  final bool isEditable;
  final FocusNode focusNode;
  final TextEditingController? controller;
  final bool obscureText;
  final String? placeholderText;

  const EditableTextField({
    super.key,
    required this.label,
    this.initialValue,
    required this.icon,
    required this.onEditTap,
    required this.isEditable,
    required this.focusNode,
    this.inputType,
    this.controller,
    this.obscureText = false,
    this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, style: font14w700.copyWith(color: Colors.grey[700])),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          keyboardType: inputType,
          focusNode: focusNode,
          readOnly: !isEditable,
          obscureText: obscureText,
          style: font16w500.copyWith(
            color: isEditable ? Colors.black87 : Colors.black54,
          ),
          decoration: InputDecoration(
            hintText: placeholderText,
            prefixIcon: Icon(icon, size: 22.sp),
            suffixIcon: IconButton(
              onPressed: onEditTap,
              icon: Icon(
                isEditable ? Icons.check_circle : Icons.edit_square,
                color: isEditable ? Colors.green : const Color(0xFF134FA2),
                size: isEditable ? 24.sp : 20.sp,
              ),
              splashRadius: 24,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            filled: true,
            fillColor: isEditable ? Colors.white : Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF134FA2)),
            ),
          ),
        ),
      ],
    );
  }
}
