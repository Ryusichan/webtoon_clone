class WebtoonDataModel {
  final String title, thumb, id;

// named constructor를 만들어 준다 data를 만들어줄때 요소정리
// 일반적으로 constructor < named constructor
  WebtoonDataModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
