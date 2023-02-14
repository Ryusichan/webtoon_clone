import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = 'today';

  void getTodayWebtoon() async {
    // data 불러오기 Uri.parse이용
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    // statuscode가 200이면 요청에 성공
    if (response.statusCode == 200) {
      // response의 body를 출력
      print(response.body);
      return;
    }
    throw Error();
  }
}
