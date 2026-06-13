import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_strings.dart';

class CustomSearch extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String)? onChanged;
  final bool enabled;

  const CustomSearch({
    super.key,
    required this.searchController,
    this.onChanged,
    required this.enabled,
  });

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        readOnly: !widget.enabled,
        onChanged: widget.onChanged,
        controller: widget.searchController,
        style: TextStyle(
          fontSize: 15,
          color: cs.onSurface,
        ),
        decoration: InputDecoration(
          hintText: AppStrings.searchTasks,
          hintStyle: TextStyle(
            color: cs.onSurfaceVariant,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: cs.onSurfaceVariant,
          ),
          suffixIcon: widget.searchController.text.isNotEmpty && widget.enabled
              ? GestureDetector(
                  onTap: () {
                    widget.searchController.clear();
                    widget.onChanged?.call('');
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: cs.onSurfaceVariant,
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
