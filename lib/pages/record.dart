import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:video_player/video_player.dart';


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
  FlutterTts flutterTts = FlutterTts();
  TextToSpeech tts = TextToSpeech();
  SpeechToText _speechToText = SpeechToText();
  String _lastWords = "";
  VideoPlayerController? _controller; //

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
    _initVideoPlayer(); //
    _setupTts();
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

  void _initVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/img/viddd.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

void _setupTts() {
  flutterTts.setStartHandler(() {
    // No need to change video playback here; start handler just starts TTS
  });

  flutterTts.setCompletionHandler(() {
    // Stop the video when TTS completes speaking
    setState(() {
      _controller?.pause(); // Optionally seek to a certain position if needed
    });
  });
}

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
   flutterTts.stop();
    _controller?.dispose();
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
        title: Column(
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
        actions: [
          Icon(Icons.phone),
          SizedBox(width: 10),
          Icon(Icons.videocam),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        
        children: [
          // Your existing UI components
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _controller != null && _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
              ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListTile(
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
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            margin: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ), // Add margin to give space around the container
            decoration: BoxDecoration(
              color: Color(
                  0xFFFFE9E0), // This is a light orange color, you may need to adjust the color to match exactly
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
            ),
            child: IntrinsicHeight(
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
            margin: EdgeInsets.only(
              top: 10,
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 141, 95),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFFB724C))),
            // BorderRadius()
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                // If listening is active show the recognized words
                _speechToText.isListening
                    ? '$_lastWords'
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
            padding: EdgeInsets.only(bottom: 10.0),
            //padding: EdgeInsets.all(20),
            child: Text(
              'Perform is listening...',
              style: TextStyle(color: Color(0xFFFF6C37)),
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Color(0xFFFB724C),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              icon: Icon(
                Icons.mic,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () async {

                // Text to speech
 // Text to speech
  String language = 'en-US';
  await flutterTts.setLanguage(language);
  String text = "Hello World. Good morning. I am an AI model that will interview you soon. I am really happy to see!";
  
  // Ensure the video is at the beginning when TTS starts
  _controller?.seekTo(Duration.zero);
  _controller?.play(); // Play the video when TTS starts

  await flutterTts.speak(text);
  
  // Note: The video will stop when TTS completes as handled in the setCompletionHandler.

                // listen Speech to text 
                // if (await _speechToText.hasPermission &&
                //     _speechToText.isNotListening) {
                //   _startListening();
                //   print("Is listening");
                // } else if (_speechToText.isListening) {
                //   _stopListening();
                //   print("stop listening");
                // } else {
                //   _initSpeechToText();
                //   print("init speech");
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
