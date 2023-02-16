import 'package:flutter/material.dart';

class WebtoonDetail extends StatelessWidget {
  final thumb, title, id;
  const WebtoonDetail(
      {super.key, required this.thumb, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          title: const Text(
            '아파트지금',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ));
  }
}
