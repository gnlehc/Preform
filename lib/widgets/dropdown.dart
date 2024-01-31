import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String content;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFFF6C37), width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFFFF6C37),
      elevation: 2,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: const Color(0xFFFF6C37),
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: const Color(
              0xFFFF6C37), // Ensures the same background for the tile header
          childrenPadding: EdgeInsets.zero,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Container(
              color: Colors.white, // Background color when expanded
              padding: const EdgeInsets.all(16.0),
              child: Text(
                content,
                style: const TextStyle(
                  color: Colors.black, // Text color for the content
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
