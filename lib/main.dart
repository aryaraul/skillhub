import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/video_player_screen.dart'; // ✅ Import video player

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: kIsWeb
        ? DefaultFirebaseOptions.web
        : DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SkillHubApp());
}

class SkillHubApp extends StatelessWidget {
  const SkillHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillHub',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/video': (context) => const VideoPlayerScreen(
              videoUrl:
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', // ✅ Test video URL
              title: 'Sample Video',
            ),
      },
    );
  }
}
