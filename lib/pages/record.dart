import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() {
  runApp(MaterialApp(
    home: RecordPage(),
  ));
}

class RecordPage extends StatefulWidget {
  @override
  RecordPageState createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  TextToSpeech tts = TextToSpeech();
  SpeechToText _speechToText = SpeechToText();
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
          mainAxisSize: MainAxisSize.min, // Use min size for the column
          children: <Text>[
            Text(
              'HR : Microsoft Azure',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFFFF6C37)),
            ),
            // You can add more Text widgets here
            Text(
              'Intern Software Engineering', // Additional text example
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black), // Example style
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
                  padding: EdgeInsets.only(
                      top: 4.0), // Reduce the top padding if necessary
                  child: Text(
                    'What is your biggest take-away in your previous job?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ), // Add margin to give space around the container
            decoration: BoxDecoration(
              color: const Color(
                  0xFFFFE9E0), // This is a light orange color, you may need to adjust the color to match exactly
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
            ),
            child: const IntrinsicHeight(
              // Ensures the row's height only takes the space it needs
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // Use the minimum space that Row children need
                children: [
                  Icon(Icons.pause,
                      color: Color(0xFFFB724C)), // Pause icon color adjusted
                  SizedBox(width: 8.0), // Spacing between the icon and text
                  Text(
                    'Timer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFB724C), // Text color adjusted
                    ),
                  ),
                  SizedBox(
                      width:
                          8.0), // Spacing between text "Timer" and the timer value
                  Text(
                    '01:53',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFB724C), // Text color adjusted
                    ),
                  ),
                  Spacer(), // This will push the icon to the end of the Row
                  Icon(
                    Icons.timer, // Icon data
                    color: Color(0xFFFB724C), // Icon color
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
                // If listening is active show the recognized words
                _speechToText.isListening
                    ? _lastWords
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    : _speechToText.isNotListening
                        ? 'Tap the microphone to start listening...'
                        : 'Speech not available',
              ),
            ),

            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         decoration: InputDecoration(
            //           hintText: 'I am from Jakarta, Indonesia..',
            //           hintStyle: TextStyle(fontSize: 14),
            //           border: InputBorder.none,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
