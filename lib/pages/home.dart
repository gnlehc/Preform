import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

import '../widgets/dashboardwidget.dart'; // Make sure the file name is correct

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // Current index of the selected tab

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Dashboard",
                style: TextStyle(
                    color: Color(0xFFFF6C37),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              DashboardWidget(
                userName: 'Chelsea Ng',
                latestScore: 'Latest Score',
                interviewType: 'HR Interview',
                company: 'Azure Microsoft',
                role: 'Intern Software Engineering',
                averageScore: '100/100',
                scores: const {
                  'Technical ability': 78,
                  'Leadership skills': 100,
                  'Team skills': 56,
                  'Presentation skills': 36,
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarTap,
      ),
    );
  }
}
