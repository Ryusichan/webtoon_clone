import 'package:flutter/material.dart';
import 'package:webappdemo/screens/home_screen.dart';
import 'package:webappdemo/server/api_service.dart';

void main() {
  ApiService().getTodayWebtoon();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'webtoony',
      home: HomeScreen(),
    );
  }
}
