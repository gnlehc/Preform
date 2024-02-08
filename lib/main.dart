import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preform/firebase_options.dart';
import 'package:preform/pages/account_page.dart';
import 'package:preform/pages/cover_letter_feedback_page.dart';
import 'package:preform/pages/cover_letter_page.dart';
import 'package:preform/pages/home.dart';
import 'package:preform/pages/interview_page.dart';
import 'package:preform/pages/login.dart';
import 'package:preform/pages/signup.dart';
import 'package:preform/pages/splashscreen.dart';
import 'package:preform/pages/record.dart';
import 'package:preform/pages/tts_testing.dart';
import 'package:preform/user_auth/user_provider.dart';
import 'package:preform/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'middleware/auth_middleware.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // materialApp -> Get
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(UserProvider());
      }),
      initialRoute: '/',
      home: RecordPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // ini buat middleware, route harus begini pake Get
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const Home(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginForm(),
        ),
        GetPage(
            name: '/signup',
            page: () => const SignUpForm(),
            middlewares: [AuthMiddleware()]),
        GetPage(
          name: '/interviewPage',
          page: () => const InterviewPage(),
        ),
        GetPage(
          name: '/coverLetterPage',
          page: () => const CoverLetterPage(),
        ),
        GetPage(
          name: '/accountPage',
          page: () => const AccountPage(),
        ),
        GetPage(
          name: '/loadingPage',
          page: () => const LoadingIndicator(),
        ),
        GetPage(
          name: '/coverLetterFeedbackPage',
          page: () {
            // Assuming the feedback text is passed as a string argument
            final String feedbackText = Get.arguments as String;
            return CoverLetterFeedbackPage(feedbackText: feedbackText);
          },
        ),
        // Other routes :
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
    return const Scaffold(
      body: SplashScreen(),
      // bottomNavigationBar: Navbar(
      //   currentIndex: _currentIndex,
      //   onTap: _onNavbarItemTapped,
      // ),
    );
  }
}
