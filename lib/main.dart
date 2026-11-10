import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Register App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6254D9),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 235, 237, 239),
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}
