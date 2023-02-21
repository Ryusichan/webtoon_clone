import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episodes,
  }) : super(key: key);

  final String episodes;

  onButtonTap() async {
    final url = Uri.parse("https://google.com");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onButtonTap, child: Text(episodes));
  }
}
