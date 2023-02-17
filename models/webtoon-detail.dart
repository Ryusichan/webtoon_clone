class WebtoonDataDetailBinding {
  final String title, about, genre, age;

// named constructor를 만들어 준다 data를 만들어줄때 요소정리
// 일반적으로 constructor < named constructor
  WebtoonDataDetailBinding.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
