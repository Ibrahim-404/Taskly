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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: TaskFilter.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = TaskFilter.values[index];
          final isActive = filter == activeFilter;
          return ChoiceChip(
            label: Text(filter.label, style: TextStyle(
              fontSize: 13,
              color: isActive ? cs.onPrimary : null,
            )),
            selected: isActive,
            selectedColor: cs.primary,
            onSelected: (_) => onFilterChanged(filter),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }
}
