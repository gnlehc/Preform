import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import 'feedback_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(MaterialApp(
    home: RecordPage(),
  ));
}

class RecordPage extends StatefulWidget {
  late final String feedbackTextFromGPT; // Added to accept feedback text

  @override
  RecordPageState createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  FlutterTts flutterTts = FlutterTts();
  TextToSpeech tts = TextToSpeech();
  bool _isSpeaking = false;

  SpeechToText _speechToText = SpeechToText();
  bool speechEnabled = false;

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
    });
  }

  void _initVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/img/interviewerDummy.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

void _setupTts() {
  flutterTts.setStartHandler(() {
    _isSpeaking = true; // TTS starts speaking
  });

  flutterTts.setCompletionHandler(() {
    // Stop the video when TTS completes speaking
    setState(() {
      _isSpeaking = false; // TTS has finished speaking
      _controller?.pause(); 
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

  // untuk pake gpt untuk generate respons dari perkataan user yang uda dijadiin text
  Future<String> getGPTtextFeedback(String _lastWords) async {
    // masukan uri & api key nya disini (untuk dari openai, coba-coba) :
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

    // use your own OpenAI API Key
    // OPENAI_API_KEY = Your own OpenAI API Key
    final apiKey =  dotenv.env['OPENAI_API_KEY'] ?? "";

    // header untuk dari openai (coba-coba)
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
      // Updated for OpenAI's expected header format
    };

    // String promptt = "You are an AI interviewer designed to simulate a professional job interview environment, with a deep understanding of various industries and the qualities that make a candidate successful in their field. The setting is a virtual interview room, comfortable yet formal, aimed at putting the interviewee at ease while highlighting the seriousness of the interview. You, with a calm and friendly voice, promotes openness and honesty. The interview process is dynamic, with You assessing the interviewee's skills, experiences, and suitability for the applied position. The conversation starts with ice-breaking questions to make the interviewee comfortable, followed by competency-based questions requiring examples from past experiences. You then delves into situational questions to evaluate problem-solving abilities and responses to challenges, adjusting questions based on the interviewee's answers stored in the $_lastWords variable. This ensures a personalized and adaptive interview experience. You uses $_lastWords to tailor follow-up questions and comments, creating a seamless and engaging dialogue. For instance, if the interviewee mentions a challenge they faced in their last project, You will use this information to ask deeper questions about the challenge, how it was overcome, and what was learned from the experience. This approach encourages the interviewee to reflect and share more about their skills and personality. Additionally, You simulates real-life job-related scenarios, asking the interviewee to describe how they would handle certain situations, including role-play exercises to assess communication skills, leadership potential, and teamwork ability. The interview concludes with an invitation for the interviewee to ask questions, maintaining a balanced communication flow. Throughout the interview, Your tone remains professional, supportive, and non-judgmental, aiming to elicit the best from the interviewee and provide a realistic simulation of a job interview. By dynamically using the $_lastWords variable, You ensures that each interview is tailored to the individual, making the experience as relevant and insightful as possible.";

    // tulis prompt nya disini [ untuk openai, coba-coba ]
    final requestBody = json.encode({
      "model": "gpt-3.5-turbo",
      // Make sure this is the correct model identifier
      "messages": [
        {
          "role": "system",
          "content":
              "You are Alex, a software engineering interviewer. Your job is to interview candidates for software engineering roles. Ask one question at a time related to software engineering and generate response based on the candidate's responses stored in the $_lastWords variable."},
        {"role": "user", "content": _lastWords}
      ],
      // TODO : max_tokennya nanti bisa diatur antara 300-500 [ 1 word = 1.3 token | $0.001 per 1000 token ]
      "max_tokens": 200,
      // ini untuk membatasi panjang kalimat / output yang dikeluarin gpt (biar hemat juga credit yang terpakai tiap keluarin output)
    });

    final response = await http.post(uri, headers: headers, body: requestBody);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      // Assuming the response format for chat completions, adjust as necessary
      return responseBody['choices'][0]['message']['content'].trim();
    } else {
      throw Exception(
          'Failed to analyze resume with GPT-3.5 Turbo: ${response.body}');
    }
  }

  // untuk convert jadi text
  Future<String> _convertToText() async {
    var textChatFeedbackGPT = await getGPTtextFeedback(_lastWords);

    return textChatFeedbackGPT;
  }

  // Method to convert text to speech for GPT
  Future<void> _textToSpeechForGPT(String text) async {
    if (_speechToText.isListening) return;
    // Assuming 'setLanguage' and 'speak' methods are synchronous. If they are not, you would need to await them as well.
    String language = 'en-US';
    tts.setLanguage(language); // Set the language for speech

    // Now, use the obtained text for speech
    await tts.speak(text); // Speak out the text
    _controller?.seekTo(Duration.zero);
    _controller?.play(); // Play the video when TTS starts
  }

  bool hasSpoken = false;

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
          onPressed: () {
            Get.toNamed("/interviewPage");
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Use min size for the column
          children: <Text>[
            Text(
              'Interview Session',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFFFF6C37)),
            ),
            // You can add more Text widgets here
            Text(
              'Software Engineer', // Additional text example
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black), // Example style
            ),
          ],
        ),
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
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Interviewer:',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              decoration: BoxDecoration(
                // Specify the border for the Container
                border: Border.all(
                  color: const Color(0xFFFF6C37), // Color of the border
                  width: 2.0, // Width of the border
                ),
                borderRadius: BorderRadius.circular(
                    12), // Optional: if you want rounded corners
              ),
              child: SingleChildScrollView(
                child: FutureBuilder<String>(
                  future: _convertToText(),
                  // the Future<String> you want to work with
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the Future is complete, display the text
                      if (snapshot.hasData) {
                        _textToSpeechForGPT(snapshot.data!);
                        // Side effect: Trigger text-to-speech when data is available
                        /*WidgetsBinding.instance.addPostFrameCallback((_) {
                          _textToSpeechForGPT(
                              snapshot.data!); // Pass the data directly
                          hasSpoken = true; // Prevent repeated calls
                        }*/
                        return Text(
                          snapshot.data!, // Use the data
                          style: TextStyle(color: Colors.black),
                        );
                      } else if (snapshot.hasError) {
                        // If the future encountered an error, display the error
                        return Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        );
                      }
                    }

                    // While the Future is not yet completed, display a loading spinner
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ),
          // Divider(height: 10, color: Colors.transparent),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          //   margin: EdgeInsets.only(
          //     left: 10.0,
          //     right: 10.0,
          //   ), // Add margin to give space around the container
          // ),
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
          /*
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            //padding: EdgeInsets.all(20),
            child: Text(
              'Preform is listening...',

              style: TextStyle(color: Color(0xFFFF6C37)),
            ),
          ),
           */
          Divider(height: 10, color: Colors.transparent),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Adjusts the alignment within the Row
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Color(0xFFFB724C),
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    icon: Icon(
                       _speechToText.isListening ? Icons.mic : Icons.mic_off,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      // listen Speech to text
                      if (_isSpeaking) return;
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
                    }),
              ),
              VerticalDivider(
                width: 10,
              ),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(50)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFC4084F),
                    // This is the background color
                    onPrimary:
                        Colors.white, // This is the color of the text and icon
                  ),
                  onPressed: () {
                    // Show loading indicator
                    // Navigate to the Cover Letter Feedback Page with the feedback
                    // setelah itu, kita oper text feedback nya ke Cover Letter Feedback Page
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FeedbackPage(conversationData: conversationManager.getHistoryForApi()),
                    ));
                    // Get.toNamed('/feedbackPage');
                  },
                  child: Text('Finish Interview'),
                ),
              ),
            ],
          ),
          Divider(height: 10, color: Colors.transparent),
        ],
      ),
    );
  }
}

// model to store the message
class Message {
  final String content;
  final String role; // 'user' or 'system'
  final DateTime timestamp;

  Message({required this.content, required this.role, required this.timestamp});
}

// model to store the conversation
class Conversation {
  List<Message> messages = [];

  void addMessage(String content, String role) {
    messages
        .add(Message(content: content, role: role, timestamp: DateTime.now()));
  }

  List<Map<String, dynamic>> toApiFormat() {
    return messages
        .map((message) => {
              "role": message.role,
              "content": message.content,
            })
        .toList();
  }
}

// to manage conversation
class ConversationManager {
  final Conversation conversation = Conversation();

  void addUserMessage(String message) {
    conversation.addMessage(message, "user");
  }

  void addSystemMessage(String message) {
    conversation.addMessage(message, "system");
  }

  // Prepare the conversation history for an API call
  List<Map<String, dynamic>> getHistoryForApi() {
    return conversation.toApiFormat();
  }
}

final ConversationManager conversationManager = ConversationManager();

// Example of sending a message to GPT-3.5 Turbo and updating conversation history
Future<void> sendMessageToGPT(String userMessage) async {
  // Update conversation history with the user's message
  conversationManager.addUserMessage(userMessage);

  // Prepare the API request payload, including the conversation history
  var payload = {
    "model": "gpt-3.5-turbo",
    "messages": conversationManager.getHistoryForApi(),
    "max_tokens": 150,
  };

  // Send the request to GPT-3.5 Turbo (pseudo-code)
  var response = await sendToGPTAPI(payload);

  print(response);

  // Assuming 'sendToGPTAPI' returns the GPT response text
  // Update conversation history with the system's (GPT's) response
  conversationManager.addSystemMessage(response);
}

Future<String> sendToGPTAPI(Map<String, dynamic> payload) async {
  const String apiKey =
      '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'; // Replace with your actual API key
  const String url = 'https://api.openai.com/v1/completions';

  // Set up headers for the request
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  // Convert the payload to a JSON string
  final String body = json.encode(payload);

  try {
    // Make the HTTP POST request to the OpenAI API
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final Map<String, dynamic> responseData = json.decode(response.body);
      // Assuming the response structure, adjust as needed
      String textResponse = responseData['choices'][0]['text'].trim();
      return textResponse;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  } catch (e) {
    // Handle any errors that occur during the request
    print('Error sending message to GPT-3.5 Turbo: $e');
    throw Exception('Error sending message to GPT-3.5 Turbo: $e');
  }
}
