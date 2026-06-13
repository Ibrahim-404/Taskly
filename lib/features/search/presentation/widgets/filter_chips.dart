import 'package:flutter/material.dart';
import 'package:tasks_manager/core/enums/task_filter.dart';

class FilterChips extends StatelessWidget {
  final TaskFilter activeFilter;
  final ValueChanged<TaskFilter> onFilterChanged;

  const FilterChips({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: TaskFilter.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = TaskFilter.values[index];
          final isActive = filter == activeFilter;
          return ChoiceChip(
            label: Text(filter.label),
            selected: isActive,
            selectedColor: cs.primary,
            onSelected: (_) => onFilterChanged(filter),
            visualDensity: VisualDensity.compact,
            showCheckmark: false,
            labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? cs.onPrimary : cs.onSurfaceVariant,
            ),
            backgroundColor: cs.surfaceContainerHighest.withValues(alpha: 0.3),
            side: isActive
                ? BorderSide.none
                : BorderSide(color: cs.outlineVariant),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
