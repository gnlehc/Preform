import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MaterialApp(home: CoverLetterPage()));
}

enum CVOption { curriculumVitae, resume }

class CoverLetterPage extends StatefulWidget {
  const CoverLetterPage({Key? key}) : super(key: key);

  @override
  State<CoverLetterPage> createState() => _CoverLetterPageState();
}

class _CoverLetterPageState extends State<CoverLetterPage> {
  CVOption? _cvOption = CVOption.curriculumVitae;
  File? _cvFile;

  void _pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null) {
      setState(() {
        _cvFile = File(result.files.single.path!);
      });
    }
  }

  void _analyzeCV() async {
    if (_cvFile != null) {
      // Implement logic cv analysis disini (pake openai api)

      // ------------------------

      // now navigate to loading page
      // Navigate to the loading page
      Navigator.of(context).pushNamed('/loadingPage');

      // Simulate loading delay
      await Future.delayed(Duration(seconds: 5));

      // After loading, navigate ke feedback page
      Navigator.of(context).pushNamed('/coverLetterFeedbackPage');
      print('Analyze CV: ${_cvFile?.path}');
    } else {
      // Prompt the user to select a file first
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a file first')),
      );
    }
  }

  void _clearSelection() {
    setState(() {
      _cvFile = null;
    });
  }

  // 2 = Cover Letter Page
  int _selectedIndex = 2;

  // for bottom navbar navigation
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/interviewPage');
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  "Analyze your CV or Resume with AI",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: const Color(0xFFFF6C37)),
                )),
          ),
          Divider(
            height: 10,
            thickness: 1,
            color: Colors.transparent,
          ),
          RadioListTile<CVOption>(
            selectedTileColor: const Color(0xFFFF6C37),
            title: const Text(
              'Curriculum Vitae',
              style: TextStyle(color: const Color(0xFFFF6C37)),
            ),
            value: CVOption.curriculumVitae,
            groupValue: _cvOption,
            onChanged: (CVOption? value) {
              setState(() {
                _cvOption = value;
              });
            },
            activeColor: const Color(0xFFFF6C37),
          ),
          RadioListTile<CVOption>(
              selectedTileColor: const Color(0xFFFF6C37),
              title: const Text(
                'Resume',
                style: TextStyle(color: const Color(0xFFFF6C37)),
              ),
              value: CVOption.resume,
              groupValue: _cvOption,
              onChanged: (CVOption? value) {
                setState(() {
                  _cvOption = value;
                });
              },
              activeColor: const Color(0xFFFF6C37)),
          SizedBox(height: 20),
          _cvFile != null
              ? Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFFF6C37), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.file_upload,
                  color: Color(0xFFFF6C37),
                  size: 24,
                ),
                SizedBox(height: 10,),
                Text('Selected File: ${_cvFile!
                    .path
                    .split('/')
                    .last}'),
                TextButton(
                  onPressed: _clearSelection,
                  child: Text('Cancel', style: TextStyle(color: Color(0xFFFF6C37)),),
                ),
              ],
            ),
          ) : Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFFF6C37), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.file_upload,
                  color: Color(0xFFFF6C37),
                  size: 24,
                ),
                TextButton(
                  onPressed: _pickCV,
                  child: Text(
                    'Upload CV .pdf',
                    style: TextStyle(
                      color: Color(0xFFFF6C37),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ) /* ElevatedButton(
                  onPressed: _pickCV,
                  child: Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                ), */
          /* Column(
                  children: [
                    Text('Selected File: ${_cvFile!.path.split('/').last}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _pickCV,
                          child: Text('Change File'),
                        ),
                        SizedBox(width: 8),
                        TextButton(
                          onPressed: _clearSelection,
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                )
                */

          , SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              // implements start analyzing
              onPressed: _analyzeCV,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 35),
                alignment: Alignment.centerLeft,
                backgroundColor: const Color(0xFFFF6C37),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Analyze',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarTap,
      ),
    );
  }
}
