import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
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
    return TextField(
      readOnly: !widget.enabled,
      onChanged: (value) {
        widget.onChanged?.call(value);
      },
      controller: widget.searchController,
      decoration: InputDecoration(
        hintText: AppStrings.searchTasks,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.grey200,
      ),
    );
  }
}
