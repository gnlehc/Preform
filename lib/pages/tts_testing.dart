import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class TtsTesting extends StatefulWidget {
  @override
  _TtsTestingState createState() => _TtsTestingState();
}

class _TtsTestingState extends State<TtsTesting> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: 'Enter Text',
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            String inputText = _textController.text;

            if (inputText.isNotEmpty) {
              await callFlaskEndpoint(inputText);

              print('Text-to-speech conversion completed!');
            } else {
              print('Please enter text before pressing the button.');
            }
          },
          child: Text('Call Flask Endpoint'),
        ),
      ],
    ));
  }

  Future<void> callFlaskEndpoint(String inputText) async {
    final Uri uri =
        Uri.parse('http://127.0.0.1:5000/text-to-speech/$inputText');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print('Text-to-speech conversion completed!');
    } else {
      print(
          'Failed to call Flask endpoint. Status code: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
