import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'utils/colors.dart' show mobileBackgroundColor;
import 'responsive/responsive_screen_layout.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/web_screen_layout.dart';

Future<void> main() async {
  if (!Platform.isAndroid) {
    return;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
        useMaterial3: true,
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
