import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechForm extends StatefulWidget {
  const TextToSpeechForm({super.key});

  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State <TextToSpeechForm> {
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
   String text = "Hello, Good Morning!";  
  final TextToSpeech tts = TextToSpeech();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:
      Column(children: [
        ElevatedButton(
          onPressed: () {
            tts.speak("Hello");
          },
          child: Text('Speak'),
        ),
      ],)
    );
  }
}