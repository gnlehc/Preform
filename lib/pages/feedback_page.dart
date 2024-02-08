import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:preform/widgets/bottom_navbar.dart';
import 'package:preform/widgets/dropdown.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _selectedIndex = 0;
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final int _score = 70;

  @override
  Widget build(BuildContext context) {
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
    final List<Map<String, String>> posFeed = [
      {
        'Feedback':
            'Impressive Technical Knowledge: Your depth of knowledge in cloud computing and your experience with AWS stood out during the technical assessment.',
      },
      {
        'Feedback':
            'Effective Problem Solving: The problem-solving exercise revealed your strong analytical skills.',
      },
      {
        'Feedback':
            'Relevant Experience: Your experiences at XYZ Solutions were certainly noteworthy.',
      },
    ];
    final List<Map<String, String>> areaImprove = [
      {
        'Improve':
            'Communication Style: While your technical explanations were thorough, there were moments where a more concise communication style would have enhanced the overall clarity.',
      },
      {
        'Improve':
            'Body Language: During the interview, your body language seemed a bit reserved.',
      },
      {
        'Improve':
            'Tailoring Responses: When discussing your experiences, try to draw explicit connections between your achievements and how they align with TechSolutions innovative approach to software development. Tailoring your responses to our company culture can create a stronger impact.',
      },
    ];
    double percent = _score / 100;
    Color progressColor =
        Color.lerp(Colors.grey, const Color(0xFFFF6C37), percent)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFFF6C37),
          ),
          onPressed: () {},
        ),
        title: const Text(
          "Feedback",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Feedback",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Text(
                "Mock Interview: Mid-Senior Software Engineering",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Positive Feedback",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(color: Color(0xFFFF6C37), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: posFeed.length,
                        itemBuilder: (context, index) {
                          return Text(
                            '${index + 1}. ${posFeed[index]['Feedback'] ?? ''}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, height: 1.5),
                          );
                        },
                      ),
                    ]),
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Areas of Improvement",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(color: Color(0xFFFF6C37), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: areaImprove.length,
                        itemBuilder: (context, index) {
                          return Text(
                            '${index + 1}. ${areaImprove[index]['Improve'] ?? ''}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, height: 1.5),
                          );
                        },
                      ),
                    ]),
                  )),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: percent,
                      center: Text(
                        _score.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xFFFF6C37),
                        ),
                      ),
                      footer: const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Overall Score',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFFF6C37),
                          ),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Colors.grey[300]!,
                      progressColor: progressColor,
                    ),
                  )),
              ...qaPairs
                  .map((qaPair) => CustomExpansionTile(
                        title: qaPair['question']!,
                        content: qaPair['answer']!,
                      ))
                  .toList(),
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
