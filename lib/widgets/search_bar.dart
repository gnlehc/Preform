import 'package:flutter/material.dart';

class SearchBarInterview extends StatefulWidget {
  const SearchBarInterview({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBarInterview> {
  final List<String> industries = [
    'All jobs',
    'Product Management',
    'Business Devwlopment',
    'Marketing',
    'Finance',
    'Recruiting',
    'IT Consulting',
    'Design'
  ];
  final List<String> interviewTypes = [
    'HR Interview',
    'User Interview',
    'Case Interview'
  ];
  final TextEditingController _searchController = TextEditingController();
  bool isFilterClicked = false;
  List<bool> isCheckedList = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildSearchBar(),
                ),
                const SizedBox(width: 16.0),
                _buildElevatedButton(),
              ],
            ),
            if (isFilterClicked) _buildFilteredList(),
          ],
        
      
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
        suffixIcon: const Icon(Icons.search, color: Colors.orange),
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
          borderSide: const BorderSide(
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
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 12),
      const Text("Industries",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      Expanded(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(
                    color: Colors.orange,
                    width: 1.0,
                  ),
                ),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      filteredItems[index],
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Checkbox(
                        checkColor: Colors.white,
                        value: isCheckedList[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedList[index] = value!;
                          });
                        }),
                  )
                ]),
              );
            }),
      ),
      const SizedBox(height: 12),
      const Text("Level",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      ListView.builder(
        itemCount: interviewTypes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2.0,
              child: ListTile(
                title: Text(interviewTypes[index]),
                trailing: Checkbox(
                  value: false, // Provide the value based on the checked state
                  onChanged: (bool? value) {
                    // Handle checkbox state change
                  },
                ),
              ),
            ),
          );
        },
      ),
    ]));
  }
}

void main() {
  runApp(const MaterialApp(
    home: SearchBarInterview(),
  ));
}
