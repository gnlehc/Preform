import 'package:flutter/material.dart';

/*
void main() {
  runApp(const MaterialApp(home: CoverLetterFeedbackPage()));
}

 */

class CoverLetterFeedbackPage extends StatefulWidget {
  final String feedbackText; // Added to accept feedback text

  const CoverLetterFeedbackPage({Key? key, required this.feedbackText}) : super(key: key);

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Feedback",
          style: TextStyle(fontWeight: FontWeight.bold),
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
              /*
              const Text(
                "Mock Interview: Mid-Senior Software Engineering",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // Your PercentageCircle widget and text
                ],
              ),
               */
              const SizedBox(height: 10),
              const Text(
                "Feedback for your Resume :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF6C37)),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFF6C37), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.feedbackText, // Display the feedback text
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                )

              )

            ],
          ),
        ),
      ),
    );
  }
}