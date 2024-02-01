import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../widgets/percentage_circle.dart';

void main() {
  runApp(MaterialApp(home: CoverLetterFeedbackPage()));
}


class CoverLetterFeedbackPage extends StatefulWidget {
  const CoverLetterFeedbackPage({Key? key}) : super(key: key);

  @override
  State<CoverLetterFeedbackPage> createState() => _CoverLetterFeedbackPageState();
}

class _CoverLetterFeedbackPageState extends State<CoverLetterFeedbackPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFFF6C37),
          ),
          onPressed: () {
            // Add your action here
            Navigator.of(context).pushNamed('/coverLetterPage');
          },
        ),
        title: const Text(
          "Feedback",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mock Interview: Mid-Senior Software Engineering",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      PercentageCircle(percentage: 0.76),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Overall Score",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFF6C37),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Positive Feedback",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }



}