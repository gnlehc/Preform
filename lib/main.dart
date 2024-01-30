
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preform/pages/interview.dart';
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
      home: MyHomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void _onNavbarItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Interview(),
      bottomNavigationBar: Navbar(
        currentIndex: _currentIndex,
        onTap: _onNavbarItemTapped,
      ),
    );
  }
}
