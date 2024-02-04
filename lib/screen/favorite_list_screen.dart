import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/quotes_screen.dart';
import 'package:investment_quotes_app_v2/database/database_service.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';
import 'package:investment_quotes_app_v2/model/Favorite.dart';


class FavoriteListScreen extends StatefulWidget {
  // const FavoriteListScreen({Key? key}) : super(key: key);
  final String likedQuote;
  FavoriteListScreen({required this.likedQuote});

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  // "이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
  // "나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
  // "다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
  // "기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",
  // "이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",

  // "이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
  // "나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
  // "다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
  // "기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",

  List<Favorite> _favoriteQuotes = [
  ];

  @override
  void initState() {
    super.initState();
    _getFavoriteQuotes();

    // 초기에 추가된 명언이 있다면 리스트에 추가
    // if (widget.likedQuote.isNotEmpty) {
    //   favoriteQuotes.add(widget.likedQuote);
    // }
  }

  Future<void> _getFavoriteQuotes() async {
    final quotes = await DatabaseService.instance.getAllFavoriteQuotes();

    if (mounted) {
      setState(() => _favoriteQuotes = quotes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _favoriteQuotes.length,
        itemBuilder: (BuildContext context, int index) {
          // return Container(
          //   padding: const EdgeInsets.all(32),
          //   child: Text(favoriteQuotes[index]),
          // );
          
          // Quote? quote = await selectQuoteById(index);
          // DatabaseConfig().selectQuoteById2(index);

          return ListTile(
            // title: Text(''),
            title: Text(_favoriteQuotes[index].quote.toString()),
            trailing: GestureDetector(
              onTap: () {
                // _toggleFavorite(favoriteQuotes[index]);
              },
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }


//_toggleFavorite()
// SharedPreferences를 사용하여 즐겨찾기에 추가 또는 삭제
// Future<void> _toggleFavorite(String quote) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String>? likedQuotes = prefs.getStringList('liked_quotes');
//   if (likedQuotes != null) {
//     if (likedQuotes.contains(quote)) {
//       // 이미 즐겨찾기에 추가된 경우, 삭제
//       likedQuotes.remove(quote);
//     } else {
//       // 즐겨찾기에 추가되지 않은 경우, 추가
//       likedQuotes.add(quote);
//     }
//     prefs.setStringList('liked_quotes', likedQuotes);
//     _loadLikedQuotes();
//   }
// }

}