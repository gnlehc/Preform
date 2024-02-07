import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preform/firebase_options.dart';
import 'package:preform/pages/home.dart';
import 'package:preform/pages/login.dart';
import 'package:preform/pages/signup.dart';
import 'package:preform/pages/splashscreen.dart';
import 'package:preform/pages/tts_testing.dart';
import 'package:preform/user_auth/user_provider.dart';
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
      home: SplashScreen(),
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
          page: () => SplashScreen(),
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
      ],
      debugShowCheckedModeBanner: false,

//     return MaterialApp(

//         // Removed initialRoute to prevent navigation to other screens on startup
//         home: const Home(),
//         // This sets Home as the first page
//         theme: ThemeData(
//           scaffoldBackgroundColor: Colors.white,
//           textTheme: GoogleFonts.dmSansTextTheme(
//             Theme.of(context).textTheme,
//           ),
//         ),
//         // Removed the '/login' and '/signup' routes, as they're not needed for initial navigation
//         debugShowCheckedModeBanner: false,

//         initialRoute: '/',
//         routes: {
//           // '/': (context) => Home(), // Home page
//           '/interviewPage': (context) => InterviewPage(),
//           '/coverLetterPage': (context) => CoverLetterPage(),
//           '/accountPage': (context) => AccountPage(),
//           '/loadingPage': (context) => LoadingIndicator(),
//           '/coverLetterFeedbackPage' : (context) => CoverLetterFeedbackPage(),
//         } // Other page
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
