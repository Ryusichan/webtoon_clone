import 'package:flutter/material.dart';
import 'package:webappdemo/models/webtoon.dart';
import 'package:webappdemo/server/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonDataBinding> webtoon = [];
  bool isLoading = true;

  void waitforWebtoon() async {
    webtoon = await ApiService.getTodayWebtoon();
    isLoading = false;
    // 화면을 새로고침하기 위해서 setstate사용
    setState(() {});
  }

// initstate에 데이터를 받아오는 함수를 호출
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitforWebtoon();
  }

  @override
  Widget build(BuildContext context) {
    print(webtoon);
    print(isLoading);
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
    );
  }
}
