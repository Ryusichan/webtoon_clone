import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webappdemo/models/webtoonDetail_model.dart';
import 'package:webappdemo/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = 'today';
  static const String id = 'id';

// http.get은 Future타잎을 반환한다 이는 당장 완료될수 있는 작업이 아니다라는걸 뜻함 = > 비동기 반환값
  static Future<List<WebtoonDataBinding>> getTodayWebtoon() async {
    List<WebtoonDataBinding> webtoonInstances = [];
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
        // webtoonInstances에 json화 시킨 데이터를 넣어준다
        final instance = WebtoonDataBinding.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getDetailWebtoon(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);

      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }
}
