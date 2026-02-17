import 'package:flutter/material.dart';

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
        hintText: 'Search tasks...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
