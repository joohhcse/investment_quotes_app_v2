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