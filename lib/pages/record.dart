import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() {
  runApp(const MaterialApp(
    home: RecordPage(),
  ));
}

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  RecordPageState createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  TextToSpeech tts = TextToSpeech();
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = "";

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

  void _initSpeechToText() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    // await speechToText.initialize();
    await _speechToText.listen(onResult: _onSpeechResult);

    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

//speech to text
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      // print("This is the result $lastWords");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
    tts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFFF6C37),
          ),
          onPressed: () {},
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Text>[
            Text(
              'HR : Microsoft Azure',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFFFF6C37)),
            ),
            Text(
              'Intern Software Engineering',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.phone),
          SizedBox(width: 10),
          Icon(Icons.videocam),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(''), // Your person image
                )),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: const ListTile(
                title: Text(
                  'Question:',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    'What is your biggest take-away in your previous job?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9E0),
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
            ),
            child: const IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.pause, color: Color(0xFFFB724C)),
                  SizedBox(width: 8.0),
                  Text(
                    'Timer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFB724C),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '01:53',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFB724C),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.timer,
                    color: Color(0xFFFB724C),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.only(
              top: 10,
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 141, 95),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFB724C))),
            // BorderRadius()
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                _speechToText.isListening
                    ? _lastWords
                    : _speechToText.isNotListening
                        ? 'Tap the microphone to start listening...'
                        : 'Speech not available',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            //padding: EdgeInsets.all(20),
            child: const Text(
              'Perform is listening...',
              style: TextStyle(color: Color(0xFFFF6C37)),
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: const Color(0xFFFB724C),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              icon: const Icon(
                Icons.mic,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () async {
                // Text to speech
                String language = 'en-US';
                tts.setLanguage(language);
                String text = "Hello World Good morning!";
                await tts.speak(text);

                // listen Speech to text
                if (await _speechToText.hasPermission &&
                    _speechToText.isNotListening) {
                  _startListening();
                  print("Is listening");
                } else if (_speechToText.isListening) {
                  _stopListening();
                  print("stop listening");
                } else {
                  _initSpeechToText();
                  print("init speech");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
