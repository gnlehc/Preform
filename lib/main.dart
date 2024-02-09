import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preform/firebase_options.dart';
import 'package:preform/pages/account_page.dart';
import 'package:preform/pages/cover_letter_feedback_page.dart';
import 'package:preform/pages/cover_letter_page.dart';
import 'package:preform/pages/explore_interview_page.dart';
import 'package:preform/pages/feedback_page.dart';
import 'package:preform/pages/home.dart';
import 'package:preform/pages/interview_page.dart';
import 'package:preform/pages/login.dart';
import 'package:preform/pages/signup.dart';
import 'package:preform/pages/splashscreen.dart';
import 'package:preform/pages/record.dart';
import 'package:preform/user_auth/user_provider.dart';
import 'package:preform/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'middleware/auth_middleware.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: ".env");

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
      home: Home(),
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
          name: '/exploreInterviewPage',
          page: () => const ExploreInterviewPage(),
        ),
        GetPage(
          name: '/recordPage',
          page: () => RecordPage(),
        ),
        GetPage(
          name: '/coverLetterFeedbackPage',
          page: () {
            // Assuming the feedback text is passed as a string argument
            final String feedbackText = Get.arguments as String;
            return CoverLetterFeedbackPage(feedbackText: feedbackText);
          },
        ),
        GetPage(
          name: '/feedbackPage',
          page: () {
            // Assuming the feedback text is passed as a string argument
            // final String interviewFeedbackText = Get.arguments as String;
            return FeedbackPage(conversationData: []);
          },
        ),
        // Other routes :
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
