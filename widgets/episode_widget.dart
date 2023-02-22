import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webappdemo/models/webtoonepisode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episodes,
    required this.webtoonID,
  }) : super(key: key);

  final WebtoonEpisodeModel episodes;
  final String webtoonID;

// launchurl 은 Future를 가져다 주는 function이기 때문에 async, await를 붙여줌
  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonID&no=${episodes.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onButtonTap, child: Text(episodes.title));
  }
}
