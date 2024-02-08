import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/bottom_navbar.dart';

void main() {
  runApp(const MaterialApp(home: AccountPage()));
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  // 2 = Account Page
  int _selectedIndex = 3;

  // for bottom navbar navigation
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/interviewPage');
        break;
      case 2:
        Navigator.pushNamed(context, '/coverLetterPage');
        break;
      case 3:
        Navigator.pushNamed(context, '/accountPage');
        break;
    }

  }

  String name = 'Chelsea Ng';
  String email = 'chelsea.ng@gmail.com';

  void _editProfile() {
    // Placeholder for edit profile logic
    // This is where you might open an edit profile page or show a modal
    print('Edit profile tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/images/chelsea.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFF6C37), // This is the background color
                onPrimary: Colors.white, // This is the color of the text and icon
              ),
              onPressed: _editProfile,
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarTap,
      ),
    );
  }



}