class WebtoonDataBinding {
  final String title, thumb, id;

// named constructor를 만들어 준다 data를 만들어줄때 요소정리
  WebtoonDataBinding.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
