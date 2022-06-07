import 'package:flutter/material.dart';
import 'package:wisatain_mobile/ui/get_started_page.dart';
import 'package:wisatain_mobile/ui/splash_page.dart';
import 'package:wisatain_mobile/ui/sign_up_page.dart';
import 'package:wisatain_mobile/ui/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/get-started': (context) => GetStarted(),
        '/sign_up_page': (context) => SignUpPage(),
        '/sign_in_page': (context) => SignInPage(),
      },
    );
  }
}
