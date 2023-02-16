import 'package:flutter/material.dart';
import 'package:webappdemo/screens/webtoon_detail.dart';

class Webtoon extends StatelessWidget {
  final String thumb, title, id;
  const Webtoon(
      {super.key, required this.thumb, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        // MaterialPageRoute와 PageRouteBuilder는 page넘어가는 방식이 ios랑 차이가 있음
        // MaterialPageRoute이 슬라이드가 적용안되서 PageRouteBuilder를 이용한 좌우 슬라이드 추가
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // offset 방향에따라 수직, 수평의 변경이 가능하다
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          pageBuilder: (context, anmation, secondaryAnimation) =>
              WebtoonDetail(id: id, title: title, thumb: thumb),
          // dialog속성을 추가하는 방법 자동으로 appbar가 닫기로 바뀐다
          // fullscreenDialog: true,
        ),
      ),
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.grey.withOpacity(0.3),
                    )
                  ]),
              child: Image.network(thumb),
            ),
          ),
          Text(title)
        ],
      ),
    );
  }
}
