import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webappdemo/models/webtoon.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = 'today';

  void getTodayWebtoon() async {
    // data 불러오기 Uri.parse이용
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    // statuscode가 200이면 요청에 성공
    if (response.statusCode == 200) {
      // json으로 변환해준다 string 값을 넘겨주면됨
      final List<dynamic> webtoons = jsonDecode(response.body);
      // 각각의 클래스하나의 요소로 만들어주고 json화 시켜줌
      for (var webtoon in webtoons) {
        // data를 dart에서 사용할수 있는 형식으로 바꿔주는 개념
        final toons = WebtoonDataBinding.fromJson(webtoon);
        print(toons.title);
      }
      return;
    }
    throw Error();
  }
}
