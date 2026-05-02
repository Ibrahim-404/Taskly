import 'package:flutter/material.dart';
import 'package:tasks_manager/core/const/app_colors.dart';
import 'package:tasks_manager/l10n/app_localizations.dart';

class CustomSearch extends StatefulWidget {
  final TextEditingController searchController;

  const CustomSearch({super.key, required this.searchController});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
      controller: widget.searchController,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.searchTasks,
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
