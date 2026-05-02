import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String? hintText;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines = 1,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          hintText: hintText ?? AppLocalizations.of(context)!.enterTaskName,
          hintStyle: TextStyle(color: AppColors.grey400, fontSize: 13),
          filled: true,
          fillColor: AppColors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.blue300, width: 1.5),
          ),
        ),
      ),
    );
  }
}
