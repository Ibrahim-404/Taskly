import 'package:flutter/material.dart';
import 'package:tasks_manager/core/theme/app_theme.dart';

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryWidget({
    super.key,
    required this.categoryName,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isSelected
              ? LinearGradient(
                  colors: AppTheme.headerGradient(context),
                )
              : null,
          color: isSelected ? null : cs.surface,
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? cs.secondary.withValues(alpha: 0.3)
                  : cs.shadow.withValues(alpha: 0.05),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: isSelected ? null : Border.all(color: cs.outlineVariant),
        ),
        child: Text(
          categoryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
