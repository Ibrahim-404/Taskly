import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(categoryName),
        selected: isSelected,
        onSelected: (_) => onTap?.call(),
        showCheckmark: false,
        visualDensity: VisualDensity.compact,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
        ),
        backgroundColor: cs.surfaceContainerHighest.withValues(alpha: 0.3),
        selectedColor: cs.primary,
        side: isSelected ? BorderSide.none : BorderSide(color: cs.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
