import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:preform/pages/feedback_page.dart';
import 'package:preform/widgets/ExploreMockInterviewCard.dart';
import 'package:preform/widgets/dropdown.dart';
import 'package:preform/widgets/prev_interview_card.dart';

import '../widgets/bottom_navbar.dart';

import '../widgets/dashboardwidget.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 0 = Home Page
  int _selectedIndex = 0;

  // for bottom navbar navigation
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
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
    int score = 90;
    double percent = score / 100;
    Color progressColor =
        Color.lerp(const Color(0xFFCE194B), const Color(0xFFFF6C37), percent)!;
    final List<Map<String, String>> qaPairs = [
      {
        'question':
            'Can you tell us about a challenging project you worked on at TechGiant Inc. and how you approached it?',
        'answer':
            'At TechGiant Inc., I was part of a team that developed a machine learning model to improve data processing efficiency. The challenge was to integrate the model seamlessly with our existing infrastructure without disrupting ongoing services.'
      },
      {
        'question':
            'What motivated you to develop a personal finance tracker app? What technologies did you use, and what did you learn from this project?',
        'answer':
            'I was motivated by the need to manage personal finances better. For this project, I used Flutter for the frontend and Firebase for the backend. I learned a lot about state management and the importance of a clean UI/UX design.'
      },
      {
        'question':
            'Can you tell us about a challenging project you worked on at TechGiant Inc. and how you approached it?',
        'answer':
            'At TechGiant Inc., I was part of a team that developed a machine learning model to improve data processing efficiency. The challenge was to integrate the model seamlessly with our existing infrastructure without disrupting ongoing services.'
      },
      {
        'question':
            'What motivated you to develop a personal finance tracker app? What technologies did you use, and what did you learn from this project?',
        'answer':
            'I was motivated by the need to manage personal finances better. For this project, I used Flutter for the frontend and Firebase for the backend. I learned a lot about state management and the importance of a clean UI/UX design.'
      },
      {
        'question':
            'Can you tell us about a challenging project you worked on at TechGiant Inc. and how you approached it?',
        'answer':
            'At TechGiant Inc., I was part of a team that developed a machine learning model to improve data processing efficiency. The challenge was to integrate the model seamlessly with our existing infrastructure without disrupting ongoing services.'
      },
      {
        'question':
            'What motivated you to develop a personal finance tracker app? What technologies did you use, and what did you learn from this project?',
        'answer':
            'I was motivated by the need to manage personal finances better. For this project, I used Flutter for the frontend and Firebase for the backend. I learned a lot about state management and the importance of a clean UI/UX design.'
      },
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const Row(children: [
              Padding(
                padding: EdgeInsets.only(top: 50, left: 10),
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6C37),
                  ),
                ),
              ),
            ]),
            Expanded(
              child: ListView(
                children: [
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
                      'Teamwork skills': 56,
                      // 'Presentation skills': 36,
                      'Organizational skills': 70
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6C37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 0,
                      ),
                      child: const Text(
                        'View previous feedback',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("📑 Previous Interview Prep",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 6),
                  Text("Continue your interview preperations",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14)),
                   SizedBox(height: 12),
                  Row(children: [
                    PrevInterviewCard(progressValue: 50, numberPercentage: 20)
                  ],)
                ],
              ),
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
