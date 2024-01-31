import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final List<String> industries = [
    'All jobs',
    'Data & Product Management',
    'Business Dev & Sales',
    'Marketing & Social Media',
    'Finance & Accounting',
    'Recruiting & People',
    'IT & Engineering',
    'Design & Creative'
  ];
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search industries',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.white, 
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.orange,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
          ),
          onChanged: (value) {
            print("Search Term: $value");
          },
        )));
  }
}
