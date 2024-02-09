import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_navbar.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:read_pdf_text/read_pdf_text.dart';

import 'cover_letter_feedback_page.dart';

void main() {
  runApp(const MaterialApp(home: CoverLetterPage()));
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

  // untuk submit cv / resume nya
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

  // untuk pake gpt untuk generate feedback
  Future<String> analyzeResumeWithGPT(String resumeText) async {
    // masukan uri & api key nya disini (untuk dari azure) :
    // final uri = Uri.parse('https://akkaselPreformResumeFeedbackGenerator.openai.azure.com/openai/deployments/gpt35_turbo_for_feedback_new/completions?api-version=2023-07-01-preview');

    // masukan uri & api key nya disini (untuk dari openai, coba-coba) :
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');
    // coba coba :
    // final uri = Uri.parse('https://akkaselpreformresumefeedbackgenerator.openai.azure.com/openai/deployments/gpt35_turbo_for_feedback_new/chat/completions?api-version=2023-07-01-preview');

    // api key dari azure :
    // const apiKey = 'b2aa888ad83f4e0ba5412abaf23139da';

    // api key dari openai (coba-coba)
    const apiKey = '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';

    // header untuk dari azure :
    /*
    final headers = {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': apiKey // Correct usage without string interpolation
    };
     */

    // header untuk dari openai (coba-coba)
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
      // Updated for OpenAI's expected header format
    };

    // tulis prompt nya disini [ untuk azure ]
    /*
    final requestBody = json.encode({
      "model": "gpt-3.5-turbo",
      "prompt": "You are an Resume Analyzer, Your job is to provide a comprehensive review of this resume and give feedback as detail as possible: $resumeText",
      "temperature": 0.7,
      "max_tokens": 300,
    });
    */

    // tulis prompt nya disini [ untuk openai, coba-coba ]
    final requestBody = json.encode({
      "model": "gpt-3.5-turbo",
      // Make sure this is the correct model identifier
      "messages": [
        {
          "role": "system",
          "content":
              "You are an expert Resume Analyzer. Provide a comprehensive review, feedback, and recommendation of this resume: $resumeText"
        },
        {"role": "user", "content": ""}
      ],
      "max_tokens": 300,
      // ini untuk membatasi panjang kalimat / output yang dikeluarin gpt (biar hemat juga credit yang terpakai tiap keluarin output)
    });

    final response = await http.post(uri, headers: headers, body: requestBody);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      //return ini kalo misalnya azure openai :
      // return responseBody['choices'][0]['text'].trim();

      // Assuming the response format for chat completions, adjust as necessary
      return responseBody['choices'][0]['message']['content'].trim();
    } else {
      throw Exception(
          'Failed to analyze resume with GPT-3.5 Turbo: ${response.body}');
    }
  }

  // untuk convert from pdf to text lalu di analisa oleh gpt
  void _analyzeCV() async {
    if (_cvFile != null) {
      // ini code kalo mau pake flask api pdf-to-text
      /*
      var uri = Uri.parse('http://10.0.2.2:5000/upload_resume'); // Replace dengan Flask API URL (kalo perlu)
      var request = http.MultipartRequest('POST', uri);

      request.files.add(await http.MultipartFile.fromPath(
        'resume', // This should match the name expected by your Flask endpoint
        _cvFile!.path,
      ));

      var response = await request.send();
       */

      // ini code kalo pdf-to-text pake library flutter
      try {
        // Read text from PDF file [ ini code kalo pdf-to-text pake library flutter ]
        String resumeText = await ReadPdfText.getPDFtext(_cvFile!.path);

        print('PDF to text result: $resumeText');

        // Show loading indicator
        Get.toNamed('/loadingPage');

        // Now we await the GPT-3.5 analysis [ ini code kalo pdf-to-text pake library flutter ]
        String textFeedbackFromGPT = await analyzeResumeWithGPT(resumeText);



        // Navigate to the Cover Letter Feedback Page with the feedback
        // setelah itu, kita oper text feedback nya ke Cover Letter Feedback Page
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              CoverLetterFeedbackPage(feedbackText: textFeedbackFromGPT),
        ));

        // Hide loading indicator
        Get.back();

        // After loading, navigate to the feedback page
        Get.to(
            () => CoverLetterFeedbackPage(feedbackText: textFeedbackFromGPT));
      } catch (e) {
        // if there are error
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to analyze CV with GPT, please try again')),
        );
      }

      // dibawah ini code kalo pdf-to-text pake flask api python
      /*
      if (response.statusCode == 200) {
        // Success - handle response
        var responseData = await response.stream.toBytes();
        // responseString -> string yang berisi
        // text yang udah kita ambil dari file pdf resume yang user input
        // tinggal nanti kita kasi prompt ke gpt buat kasi feedback
        var responseString = String.fromCharCodes(responseData);
        print('Response from server: $responseString');

        // Ensure to decode the JSON if the response is in JSON format
        var decodedResponse = json.decode(responseString);
        var resumeText = decodedResponse['text']; // Adjust this based on your actual JSON response structure

        try {
          // Now we await the GPT-3.5 analysis
          var textFeedbackFromGPT = await analyzeResumeWithGPT(resumeText);

          // Navigate to the Cover Letter Feedback Page with the feedback
          // setelah itu, kita oper text feedback nya ke Cover Letter Feedback Page
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoverLetterFeedbackPage(feedbackText: textFeedbackFromGPT),
          ));

          // Navigate to the loading page
          // Navigator.of(context).pushNamed('/loadingPage');

          // Simulate loading delay
          // await Future.delayed(Duration(seconds: 5));

          // Hide loading indicator
          Get.back();

          // After loading, navigate to the feedback page
          Get.to(() => CoverLetterFeedbackPage(feedbackText: textFeedbackFromGPT));
        } catch (e) {
          // if there are error
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to analyze CV with GPT, please try again')),
          );
        }
*/
    }
    /*
    else {
      // Error - handle accordingly
      // Hide loading indicator
      // Get.back();
      print('Failed to upload CV.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to analyze CV, please try again')),
      );
    }
     */
    else {
      // Prompt the user to select a file first
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file first')),
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
        Navigator.pushNamed(context, '/exploreInterviewPage');
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
          const Flexible(
            child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  "Analyze your CV or Resume with AI",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color(0xFFFF6C37)),
                )),
          ),
          const Divider(
            height: 10,
            thickness: 1,
            color: Colors.transparent,
          ),
          RadioListTile<CVOption>(
            selectedTileColor: const Color(0xFFFF6C37),
            title: const Text(
              'Curriculum Vitae',
              style: TextStyle(color: Color(0xFFFF6C37)),
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
                style: TextStyle(color: Color(0xFFFF6C37)),
              ),
              value: CVOption.resume,
              groupValue: _cvOption,
              onChanged: (CVOption? value) {
                setState(() {
                  _cvOption = value;
                });
              },
              activeColor: const Color(0xFFFF6C37)),
          const SizedBox(height: 20),
          _cvFile != null
              ? Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFFF6C37), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.file_upload,
                        color: Color(0xFFFF6C37),
                        size: 24,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Selected File: ${_cvFile!.path.split('/').last}'),
                      TextButton(
                        onPressed: _clearSelection,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Color(0xFFFF6C37)),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFFF6C37), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.file_upload,
                        color: Color(0xFFFF6C37),
                        size: 24,
                      ),
                      TextButton(
                        onPressed: _pickCV,
                        child: const Text(
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

          ,
          const SizedBox(height: 20),
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
