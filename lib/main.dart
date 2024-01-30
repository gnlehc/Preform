import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preform/pages/interview.dart';
import 'package:preform/pages/login.dart';
import 'package:preform/pages/signup.dart';
import 'package:preform/pages/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:preform/user_auth/user_provider.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDmi0z9QBvUdHwPd__TUWxYU4oAEGXccvY",
    appId: "1:813117776614:web:78ef3cea1628dc4a289127",
    messagingSenderId: "813117776614",
    projectId: "preform-f68e6",
  ));
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'DMSans',
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginForm(),
          '/signup': (context) => SignUpForm(),
        });
  }
}
