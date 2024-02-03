// import 'package:flutter/material.dart';
// import '../widgets/bottom_navbar.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _selectedIndex = 0; // Current index of the selected tab

//   void _onNavBarTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My App'),
//       ),
//       body: const Center(),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemSelected: _onNavBarTap,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/dropdown.dart';
import '../widgets/dashboardwidget.dart'; // Make sure the file name is correct

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 0 = Home Page
  int _selectedIndex = 0; // Current index of the selected tab
  // Example score to pass to the ScoreIndicator
  int _score = 90; // This can be any value from 1 to 100

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

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage for the circular indicator
    double percent = _score / 100;

    // Define the gradient color based on the score
    Color progressColor = Color.lerp(Colors.grey, Colors.orange, percent)!;

    // Define your questions and answers for the CustomExpansionTile
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
      // ... add other question-answer pairs
    ];

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24.0, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF6C37),
                  ),
                ),
              ),
            ]
          ),

          Expanded(
            child: ListView(
              children: [
                DashboardWidget(
                  userName: 'Chelsea Ng',
                  latestScore: 'Latest Score',
                  interviewType: 'HR Interview',
                  role: 'Azure Microsoft: Intern Software Engineering',
                  averageScore: '100/100',
                  scores: {
                    'Technical ability': 78,
                    'Leadership skills': 100,
                    'Team skills': 56,
                    'Presentation skills': 36,
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: percent,
                    center: Text(
                      _score.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    footer: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Overall Score',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.grey[300]!,
                    progressColor: progressColor,
                  ),
                ),
                // ... Add other widgets or CustomExpansionTiles
                // Insert CustomExpansionTiles here
                ...qaPairs
                    .map((qaPair) => CustomExpansionTile(
                  title: qaPair['question']!,
                  content: qaPair['answer']!,
                ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarTap,
      ),
    );

  }
}
