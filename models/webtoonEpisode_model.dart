class WebtoonEpisodeModel {
  final String id, title, rating, date;

// named constructor를 만들어 준다 data를 만들어줄때 요소정리
// 일반적으로 constructor < named constructor
  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        rating = json['rating'],
        date = json['date'];
}
