import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:preform/widgets/navbar.dart';

class Interview extends StatefulWidget {
  const Interview({Key? key}) : super(key: key);

  @override
  State<Interview> createState() => _InterviewState();
}

class _InterviewState extends State<Interview> {
  late String? _chosenValue = 'Software Engineer';
  late String? _industryValue = 'Cyber Security';
  final List<String> items = [
    'React Js',
    'Flutter',
    'Golang',
    'PostgreSQL',
    'Oracle'
  ];
  final List<String> level = ['Internship', 'Entry-Level', 'Mid-Senior Level'];
  final List<bool> checkboxValues = [false, false, false, false, false];
  final List<bool> levelcheckboxValues = [false, false, false];

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
              28.0, 50.0, 28.0, 0), // Adjust top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "🎨 Personalized Practice",
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFFC4084F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Industry",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              PopupMenuButton<String>(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC4084F),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _industryValue ?? 'Select Industry',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
                onSelected: (String value) {
                  setState(() {
                    _industryValue = value;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'IT Consulting',
                      child: Text('IT Consulting'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Cyber Security',
                      child: Text('Cyber Security'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Cloud Computing',
                      child: Text('Cloud Computing'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Big Data',
                      child: Text('Big Data'),
                    ),
                  ];
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Position",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              PopupMenuButton<String>(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC4084F),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _chosenValue ?? 'Select Position',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
                onSelected: (String value) {
                  setState(() {
                    _chosenValue = value;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Front-End Developer',
                      child: Text('Front-End Developer'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Back-End Developer',
                      child: Text('Back-End Developer'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Software Engineer',
                      child: Text('Software Engineer'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Data Analyst',
                      child: Text('Data Analyst'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'AI Engineer',
                      child: Text('AI Engineer'),
                    ),
                  ];
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Technical Requirements',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFC4084F),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 1),
                          title: Text(items[index]),
                          dense: true, // Make ListTile dense
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          trailing: Checkbox(
                            value: checkboxValues[index],
                            onChanged: (bool? value) {
                              setState(() {
                                checkboxValues[index] = value ?? false;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 30),
                            backgroundColor: const Color(0xFFC4084F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 20,
                              ),
                              Text(
                                'Add your own requirement',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Level',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFC4084F),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0), // Adjust top and bottom padding
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: level.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical:
                                  1), // Remove horizontal and vertical padding
                          title: Text(level[index]),
                          dense: true, // Make ListTile dense
                          visualDensity: const VisualDensity(
                              horizontal: 0,
                              vertical: -4), // Adjust vertical density
                          trailing: Checkbox(
                            value: levelcheckboxValues[index],
                            onChanged: (bool? value) {
                              setState(() {
                                levelcheckboxValues[index] = value ?? false;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Work Experience',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  labelText: 'Add your work experience...',
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFC4084F),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFC4084F), width: 2.0),
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 35),
                  alignment: Alignment.centerLeft,
                  backgroundColor: const Color(0xFFC4084F),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Now',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
