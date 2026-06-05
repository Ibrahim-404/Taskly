import 'package:flutter/material.dart';
import 'package:tasks_manager/features/tasks/presentation/widgets/custom_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [CustomSearch(searchController: TextEditingController())],
      ),
    );
  }
}
