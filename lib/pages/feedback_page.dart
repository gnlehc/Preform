import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:preform/widgets/bottom_navbar.dart';
import 'package:preform/widgets/dropdown.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FeedbackPage extends StatefulWidget {
  final List<Map<String, dynamic>> conversationData;

  const FeedbackPage({Key? key, required this.conversationData}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}


class _FeedbackPageState extends State<FeedbackPage> {
  String interviewFeedback = "";

  @override
  void initState() {
    super.initState();
    generateFeedback();
  }

  // untuk mengirim message ke gpt
  Future<String> sendMessageToGPT(dynamic conversationData) async {
    // use your own OpenAI API Key
    // OPENAI_API_KEY = Your own OpenAI API Key
    final String apiKey =  dotenv.env['OPENAI_API_KEY'] ?? "";
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    // Prepare your conversation data for the API request.
    // This is an example of how you might format your conversation data.
    // Adjust this according to the structure of your conversationData.
    final requestBody = json.encode({
      'model': 'gpt-3.5-turbo', // or another model like "gpt-3.5-turbo", check OpenAI documentation for available models
      "messages": [
        {
          "role": "system",
          "content":   _formatPrompt(conversationData) // Format your prompt based on conversation data
        },
        {"role": "user", "content": " "}
      ],
      'temperature': 0.7,
      'max_tokens': 300,
      'top_p': 1.0,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    });

    try {
      final response = await http.post(uri, headers: headers, body: requestBody);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // Assuming the response format for chat completions, adjust as necessary
        return responseBody['choices'][0]['message']['content'].trim();
      } else {
        throw Exception('Failed to get response from OpenAI: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to send message to GPT: $e');
    }
  }

  String _formatPrompt(dynamic conversationData) {
    // awalan prompt
    String prompt = "Given the conversation: \n";
    // Assuming conversationData is a List of Map objects or similar
    for (var message in conversationData) {
      prompt += "${message['role']}: ${message['content']}\n";
    }
    // lanjutan prompt
    prompt += "Generate feedback and analysis based on interviewee answers in the interview sessions before";
    return prompt;
  }

  // untuk generate feedback terkait interview
  void generateFeedback() async {
    // Use the conversation data to generate feedback using GPT
    // This is a placeholder for your logic to communicate with GPT
    String generatedFeedback = await sendMessageToGPT(widget.conversationData);
    setState(() {
      interviewFeedback = generatedFeedback;
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
          onPressed: () {
            Get.toNamed("/interviewPage");
          },
        ),
        title: const Text(
          "Feedback",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.white,
      ),
      body: interviewFeedback.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(interviewFeedback),
        ),
      ),

        // di-comment dulu karna gua mau bikin ui baru yang ai generated
        /*
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
        */
    );
  }
}
