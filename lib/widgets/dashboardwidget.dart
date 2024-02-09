import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardWidget extends StatelessWidget {
  final String userName;
  final String latestScore;
  final String interviewType;
  final String company;
  final String role;
  final String averageScore;
  final Map<String, int> scores;

  const DashboardWidget({
    Key? key,
    required this.userName,
    required this.latestScore,
    required this.interviewType,
    required this.company,
    required this.role,
    required this.averageScore,
    required this.scores,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const gradientStartColor = Colors.redAccent;
    const gradientEndColor = Color(0xFFCE194B);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: Icon(Icons.person),
                ),

                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, $userName',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Average Score $averageScore',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )),
                // Average score
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '$interviewType: $company',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF46008C),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 35),
                      const Text(
                        "100/100",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        role,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                      Expanded(child: const Text(
                        "Average Score",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),),

                    ],
                  ),
                  const SizedBox(height: 16),
                  // Performance indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: scores.entries
                        .map((entry) =>
                            _buildScoreIndicator(entry.key, entry.value))
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
    final colorMap = {
      'Technical ability': Colors.pinkAccent,
      'Leadership skills': Colors.orange,
      'Teamwork skills': Colors.amber,
      // 'Presentation skills': Colors.green,
      'Organizational skills': Colors.purple,
    };

    double percent = score / 100.0;
    return Expanded(
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 56.0,
            lineWidth: 5.0,
            percent: percent,
            center: Text(
              '$score',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            progressColor: colorMap[skill] ?? Colors.grey,
            backgroundColor: Colors.grey[300]!,
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 60,
            height: 40,
            child: Text(
              skill,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
