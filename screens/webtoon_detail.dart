import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webappdemo/models/webtoondetail_model.dart';
import 'package:webappdemo/models/webtoonepisode_model.dart';
import 'package:webappdemo/server/api_service.dart';
import 'package:webappdemo/widgets/episode_widget.dart';

class WebtoonDetail extends StatefulWidget {
  final String thumb, title, id;

  const WebtoonDetail({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  State<WebtoonDetail> createState() => _WebtoonDetailState();
}

class _WebtoonDetailState extends State<WebtoonDetail> {
  // 초기화하고 싶은 property가 있지만 constructor에서 불가능한 경우 late를 붙여서 함수로 initState에서 초기화진행
  // initState는 build보다 먼저 호출됨

  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  // 모바일사용자에게 등록해주는  pakage를 사용자의 클래스에 등록
  late SharedPreferences prefs;
  // state등록해준다
  bool isLiked = false;

  Future initPrefs() async {
    // 사용자의 connection에 instance를 등록해준다.
    prefs = await SharedPreferences.getInstance();
    // List<String>? string일수도있고 아닐수도 있다 최초에 등록한 list는 내용을 알수 없기때문
    // 그래서 likedToons상태를 체크해준다
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      // 현재 대상 아이디에 좋아요를 누른적이있는지 확인여부
      // widget의 대상을 추격하는건 현재는 state상태이고 WebtoonDetail의 id를 추격하기위해서
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      } else {}
    } else {
      // 사용자 최초등록시 상황정리
      // likedToons이 최초에 null 아니라면 등록해준다 Future이기때문에 await를 붙여줌
      await prefs.setStringList('likedToons', []);
    }
    print(isLiked);
  }

  @override
  void initState() {
    super.initState();

    // stateful로 바꿔줌으로써 Future를 안전하게 초기화 진행가능
    webtoon = ApiService.getDetailWebtoon(widget.id);
    episodes = ApiService.getEpisodeWebtoon(widget.id);

    initPrefs();
  }

  onFavoriteTap() async {
    // 'likedToons' 리스트 가져오기
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }

      // 마지막에 최종결정된 liked를 prefs에 넣어줌
      await prefs.setStringList('likedToons', likedToons);
      // 누를때마다 state변경
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: onFavoriteTap,
              icon: Icon(isLiked
                  ? Icons.favorite_outlined
                  : Icons.favorite_outline_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  // widget은 WebtoonDetail를 의미한다 많은 staful방식으로 변경되었기때문에 widget을통해 접근이 가능하다
                  tag: widget.id,
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
                    child: Image.network(widget.thumb),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: webtoon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text('${snapshot.data!.genre} / ${snapshot.data!.age}')
                    ],
                  );
                }
                return const Text('...');
              },
            ),
            FutureBuilder(
                future: episodes,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.separated(
                      itemBuilder: (context, index) {
                        var episodes = snapshot.data![index];
                        return Episode(
                          episodes: episodes,
                          webtoonID: widget.id,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: snapshot.data!.length,
                    ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                }))
          ],
        ),
      ),
    );
  }
}
