import 'package:flutter/material.dart';
import 'package:webappdemo/models/webtoon.dart';
import 'package:webappdemo/server/api_service.dart';

// state를 사용하지않고 fluter 위젯으로 대체하기
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // state를 사용하지 않고 future로 값을 받아오기;
  Future<List<WebtoonDataBinding>> webtoons = ApiService.getTodayWebtoon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          title: const Text(
            '아파트지금',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
        // 위젯으로 state, setstate등을 사용하지 않고 화면의 변화를 줄수 있다
        body: FutureBuilder(
          // await를 쓸필요가 없다 자동적으로 Futurebuilder에서 처리해주기 때문이다
          future: webtoons,
          // snapshot은 Future의 상태
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Text('there is data');
            } else {
              return const Text('Loading...');
            }
          },
        ));
  }
}
