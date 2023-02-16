import 'package:flutter/material.dart';

class Webtoon extends StatelessWidget {
  final thumb, title, id;
  const Webtoon(
      {super.key, required this.thumb, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 250,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(10, 10),
                  color: Colors.grey.withOpacity(0.3),
                )
              ]),
          child: Image.network(thumb),
        ),
        Text(title)
      ],
    );
  }
}
