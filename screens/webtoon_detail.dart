import 'package:flutter/material.dart';
import 'package:webappdemo/models/webtoonDetail_model.dart';
import 'package:webappdemo/models/webtoonEpisode_model.dart';
import 'package:webappdemo/server/api_service.dart';
import 'package:webappdemo/widgets/episode_widget.dart';

class WebtoonDetail extends StatefulWidget {
  final String thumb, title, id;

  const WebtoonDetail(
      {super.key, required this.thumb, required this.title, required this.id});

  @override
  State<WebtoonDetail> createState() => _WebtoonDetailState();
}

class _WebtoonDetailState extends State<WebtoonDetail> {
  // 초기화하고 싶은 property가 있지만 constructor에서 불가능한 경우 late를 붙여서 함수로 initState에서 초기화진행
  // initState는 build보다 먼저 호출됨

  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();

    // stateful로 바꿔줌으로써 Future를 안전하게 초기화 진행가능
    webtoon = ApiService.getDetailWebtoon(widget.id);
    episodes = ApiService.getEpisodeWebtoon(widget.id);
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
                  fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w600),
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
                        var episodes = snapshot.data![index].title;
                        return Episode(episodes: episodes);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
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
