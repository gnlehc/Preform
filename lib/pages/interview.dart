import 'package:flutter/material.dart';

class Interview extends StatefulWidget {
  const Interview({super.key});

  @override
  State<Interview> createState() => _InterviewState();
}

class _InterviewState extends State<Interview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(40),
        color: Colors.white,
        child: const SingleChildScrollView(
          child: Row(
            children: [
              Text(
                "Start Interview",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFF6C37),
                ),
              )
            ],
          ),
        ));
  }
}
