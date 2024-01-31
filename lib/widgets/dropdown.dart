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
        side: BorderSide(color: Colors.orange, width: 2.0), // Border color and width
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.orange, // Card background color
      elevation: 0, // Removes shadow to maintain the border visibility
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes the divider when expanded
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [
            Container(
              color: Colors.white, // Background color when expanded
              padding: const EdgeInsets.all(16.0),
              child: Text(
                content,
                style: TextStyle(
                  color: Colors.black, // Text color for the content
                ),
              ),
            ),
          ],
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: Colors.orange, // Ensures the same background for the tile header
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }
}
