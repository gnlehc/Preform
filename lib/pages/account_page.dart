import 'package:flutter/material.dart';
import 'package:preform/user_auth/user_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navbar.dart';

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
        Navigator.pushNamed(context, '/exploreInterviewPage');
        break;
      case 2:
        Navigator.pushNamed(context, '/coverLetterPage');
        break;
      case 3:
        Navigator.pushNamed(context, '/accountPage');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: const Center(
            child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Icon(Icons.person),
            ),
            SizedBox(height: 12),
            Text("Chelsea Ng",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("chelseang@gmail.com",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal))
          ],
        )),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarTap,
      ),
    );
  }
}
