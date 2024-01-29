import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preform/pages/interview.dart';
import 'package:preform/pages/login.dart';
import 'package:preform/pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginForm(),
        }
    );
  }
}
