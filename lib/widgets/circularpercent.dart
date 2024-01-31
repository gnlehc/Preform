import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ScoreIndicator extends StatelessWidget {
  final int score;

  ScoreIndicator({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage for the circular indicator
    double percent = score / 100;

    // Define the gradient color based on the score
    Color progressColor = Color.lerp(Colors.grey, Colors.orange, percent)!;

    return CircularPercentIndicator(
      radius: 100.0,
      lineWidth: 10.0,
      percent: percent,
      center: Text(
        score.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      footer: const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          'Overall Score',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: Colors.black,
          ),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.grey[300]!,
      progressColor: progressColor,
    );
  }
}
