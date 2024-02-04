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

  void _analyzeCV() async  {
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
    return Scaffold(backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RadioListTile<CVOption>(
            title: const Text('Curriculum Vitae', style: TextStyle(color: const Color(0xFFFF6C37)),),
            value: CVOption.curriculumVitae,
            groupValue: _cvOption,
            onChanged: (CVOption? value) {
              setState(() {
                _cvOption = value;
              });
            },
          ),
          RadioListTile<CVOption>(
            title: const Text('Resume',style: TextStyle(color: const Color(0xFFFF6C37)),),
            value: CVOption.resume,
            groupValue: _cvOption,
            onChanged: (CVOption? value) {
              setState(() {
                _cvOption = value;
              });
            },
          ),
          SizedBox(height: 20),
          _cvFile != null
              ? Column(
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
          ): ElevatedButton(
            onPressed: _pickCV,
            child: Text('Upload CV'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _analyzeCV,
            child: Text('Analyze'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),


      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onNavBarTap,
      ),
    );
  }



}