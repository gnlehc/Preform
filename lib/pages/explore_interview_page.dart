import 'package:flutter/material.dart';
import 'package:preform/pages/feedback_page.dart';
import 'package:preform/pages/interview_page.dart';
import 'package:preform/widgets/ExploreMockInterviewCard.dart';
import 'package:preform/widgets/bottom_navbar.dart';
import 'package:preform/widgets/search_bar.dart';

class ExploreInterviewPage extends StatefulWidget {
  const ExploreInterviewPage({super.key});

  @override
  State<ExploreInterviewPage> createState() => _ExploreInterviewPageState();
}

class _ExploreInterviewPageState extends State<ExploreInterviewPage> {
  int _selectedIndex = 1;

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(),
                Text("🔍 Explore Mock Interviews",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text("Practice with these top industries mock-up interviews!",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                SizedBox(height: 12),
                SearchBarInterview(),
                SizedBox(height: 12),
                ExploreMockInterviewCard(),
                SizedBox(height: 12),
                Text("🎨 Personalized Practice",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text(
                    "Haven’t found an interview that’s suitable for you? Customize your own interview requirements!",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                SizedBox(height: 12),
                Container(
                  width: 129,
                  child: SizedBox(
                    width: double.infinity, // Expand the SizedBox to fill the container width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InterviewPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        backgroundColor: Color(0xFFDE545A),
                        foregroundColor: Color(0xFFB93982),
                        elevation: 0, // No shadow
                        minimumSize: Size(
                          0,
                          0,
                        ), // Allow the button to be as small as needed
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Center the text horizontally
                          children: [
                            Expanded(
                              child: Text(
                                'Customize now!',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            )
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarTap,
      ),
    );
  }
}
