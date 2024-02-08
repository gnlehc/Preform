import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TtsTesting extends StatefulWidget {
  const TtsTesting({super.key});

  @override
  _TtsTestingState createState() => _TtsTestingState();
}

class _TtsTestingState extends State<TtsTesting> {
  final TextEditingController _textController = TextEditingController();
  AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Enter Text',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            String inputText = _textController.text;
            if (inputText.isNotEmpty) {
              await getTextToSpeech(inputText);
              print('Text-to-speech conversion completed!');
            } else {
              print('Please enter text before pressing the button.');
            }
          },
          child: const Text('Call Flask Endpoint'),
        ),
      ],
    ));
  }

  Future<void> getTextToSpeech(inputText) async {
    final String serverUrl = 'http://10.0.2.2:5000/send-text/';

    final response = await http.get(Uri.parse('$serverUrl$inputText'));
    if (response.statusCode == 202) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final String jobId = jsonResponse['job_id'];
      print('Job accepted with ID: $jobId');
      String audioUrl = 'http://10.0.2.2:5000/get-audio/$jobId';
      _audioPlayer.play(UrlSource(audioUrl));
    } else {
      // Handle error
      print('Error: ${response.body}');
    }
  }

  // Future<void> _playAudio(String audioUrl) async {
  //   _audioPlayer.play(UrlSource(audioUrl)).then((result) {
  //     if (result == 1) {
  //       print('Audio played successfully');
  //     } else {
  //       print('Error playing audio');
  //     }
  //   });
  // }

  // Future<void> callFlaskEndpoint(String inputText) async {
  //   final Uri uri = Uri.parse('http://10.0.2.2:5000/text-to-speech/$inputText');

  //   try {
  //     final response = await http.get(uri);
  //     final AudioPlayer audioPlayer = AudioPlayer();

  //     if (response.statusCode == 200) {
  //       final Uint8List bytes = Uint8List.fromList(response.bodyBytes);
  //       await audioPlayer.setUrl('', bytes: bytes);
  //       await audioPlayer.play();
  //       print('Audio played');
  //     } else {
  //       print(
  //           'Failed to call Flask endpoint. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //   }
  // }
  // Future<void> callFlaskEndpoint(String inputText) async {
  //   final apiKey = "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";
  //   final openAiUrl = "https://api.openai.com/v1";

  //   try {
  //     // Chat Completions
  //     final chatCompletionsUrl = "$openAiUrl/chat/completions";
  //     final chatCompletionsResponse = await http.post(
  //       Uri.parse(chatCompletionsUrl),
  //       headers: {
  //         HttpHeaders.authorizationHeader: "Bearer $apiKey",
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       },
  //       body: jsonEncode({
  //         "model": "gpt-4-vision-preview",
  //         "messages": [
  //           {
  //             "role": "user",
  //             "content": [
  //               {"type": "text", "text": inputText}
  //             ],
  //           }
  //         ],
  //         "max_tokens": 300,
  //       }),
  //     );

  //     if (chatCompletionsResponse.statusCode == 200) {
  //       final chatCompletionsData = jsonDecode(chatCompletionsResponse.body);
  //       final textInput =
  //           chatCompletionsData['choices'][0]['message']['content'];

  //       // Text-to-Speech
  //       final textToSpeechUrl = "$openAiUrl/audio/speech";
  //       final textToSpeechResponse = await http.post(
  //         Uri.parse(textToSpeechUrl),
  //         headers: {
  //           HttpHeaders.authorizationHeader: "Bearer $apiKey",
  //           HttpHeaders.contentTypeHeader: "application/json",
  //         },
  //         body: jsonEncode({
  //           "model": "tts-1",
  //           "voice": "nova",
  //           "input": textInput,
  //         }),
  //       );

  //       if (textToSpeechResponse.statusCode == 200) {
  //         final speechData = jsonDecode(textToSpeechResponse.body);
  //         final audioBytes = base64Decode(speechData['audio']);

  //         final tempDir = await getTemporaryDirectory();
  //         final tempFile = File("${tempDir.path}/speech_nova3.mp3");
  //         await tempFile.writeAsBytes(audioBytes);
  //         // Play the audio file
  //         playAudioFile(tempFile.path);
  //       } else {
  //         print(
  //             "Text-to-Speech request failed with status code ${textToSpeechResponse.statusCode}");
  //       }
  //     } else {
  //       print(
  //           "Chat Completions request failed with status code ${chatCompletionsResponse.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  // void playAudioFile(String filePath) {
  //   AudioPlayer audioPlayer = AudioPlayer();
  //   audioPlayer.setUrl(filePath);
  //   audioPlayer.play();
  // }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
