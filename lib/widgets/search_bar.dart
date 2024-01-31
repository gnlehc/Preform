import 'package:flutter/material.dart';

class SearchBarInterview extends StatefulWidget {
  const SearchBarInterview({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBarInterview> {
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
  bool isFilterClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildSearchBar(),
                ),
                SizedBox(width: 16.0),
                _buildElevatedButton(),
              ],
            ),
            if (isFilterClicked) _buildFilteredList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        hintText: 'Search industries',
        hintStyle: const TextStyle(fontSize: 14.0),
        suffixIcon: Icon(Icons.search, color: Colors.orange),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 4.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(
            color: Colors.orange,
          ),
        ),
      ),
      onChanged: (value) {
        print("Search Term: $value");
      },
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isFilterClicked = !isFilterClicked;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF6C37),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(5.0),
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage('assets/img/filter.png'),
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilteredList() {
    List<String> filteredItems = industries.where((item) {
      return item.toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text("Industries"),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Colors.orange,
                      width: 1.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            filteredItems[index],
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                // Handle checklist button click
                             },
                            ),
                          )
                      )
                    ]
                  )
              }
            );
            },
            )
            )
            
}


void main() {
  runApp(MaterialApp(
    home: SearchBarInterview(),
  ));
}
