import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardWidget extends StatelessWidget {
  final String userName;
  final String latestScore;
  final String interviewType;
  final String role;
  final String averageScore;
  final Map<String, int> scores;

  DashboardWidget({
    Key? key,
    required this.userName,
    required this.latestScore,
    required this.interviewType,
    required this.role,
    required this.averageScore,
    required this.scores,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gradient background colors
    final gradientStartColor = Colors.redAccent; // replace with start gradient color
    final gradientEndColor = Colors.red; // replace with end gradient color

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientStartColor, gradientEndColor],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User details and average score
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Placeholder for user image
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: Icon(Icons.person), // Placeholder for user image icon
                ),
                // Welcome text
                Expanded(
                  child: Text(
                    'Welcome, $userName',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Average score
                Text(
                  'Average Score\n$averageScore',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            SizedBox(height: 16),
            // White box for details and indicators
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '$interviewType: $role',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  // Performance indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: scores.entries
                        .map((entry) => _buildScoreIndicator(entry.key, entry.value))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreIndicator(String skill, int score) {
    // Custom colors for each indicator
    final colorMap = {
      'Technical ability': Colors.pinkAccent,
      'Leadership skills': Colors.orange,
      'Team skills': Colors.amber,
      'Presentation skills': Colors.green,
      'Organizational skills': Colors.purple,
    };

    double percent = score / 100.0;
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: percent,
          center: Text(
            '$score',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          progressColor: colorMap[skill] ?? Colors.grey, // Default color if skill not found
          backgroundColor: Colors.grey[300]!,
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
        ),
        SizedBox(height: 8),
        Text(
          skill,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}
