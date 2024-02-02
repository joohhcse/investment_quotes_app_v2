import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/favorite_list_screen.dart';
import 'package:investment_quotes_app_v2/database/database_service.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {

  // final List<String> quotes = [
  List<Quote> _quotes = [
    // "1이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
    // "2나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
    // "3다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
    // "4기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",
    // "5이것은 성공적인 투자 비결 중 하나다.\n주식이 아닌 회사에 집중하라. \n\n - 피터 린치",
    // "6나는 형편없는 산업에서 훌륭한 회사를 항상 찾고 있다. \n컴퓨터나 의료 기술과 같이 빠르게 성장하는 위대한 산업은 너무 많은 관심과 너무 많은 경쟁자를 끌어들인다. \n\n - 피터 린치",
    // "7다른 사람들이 다음 기적을 쫓고 있을 때에도 \n당신이 이해하고, 믿고, 지키려고 하는 것만 사라. \n\n - 피터 린치 ",
    // "8기본적인 이야기는 단순하고 끝이 없다. \n주식은 복권이 아니다. \n모든 주식에는 회사가 붙어 있다. \n\n - 피터 린치 ",
  ];

  @override
  void initState() {
    super.initState();
    // quotes.shuffle();  //temp remove
    // _getQuotes();
  }

  Future<void> _getQuotes() async {
    final quotes = await DatabaseService.instance.getAllQuotes();
    if (mounted) {
      setState(() => _quotes = quotes);
    }
    print('_quotes.length >>');
    print(_quotes.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _quotes.length,
        itemBuilder: (context, index) {
          return QuotePage(
            quote: _quotes[index].toString(),
            onLike: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FavoriteListScreen(likedQuote: quotes[index]),
              //   ),
              // );
            },
          );
        },
        physics: BouncingScrollPhysics(),
      ),
    );
  }

// Future<void> addFavorite(String quote) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String>? favorites = prefs.getStringList('favorites') ?? [];
//   favorites.add(quote);
//   prefs.setStringList('favorites', favorites);
//   debugPrint('log > ');
//   debugPrint(favorites.toString());
// }

}

class QuotePage extends StatelessWidget {
  final String quote;
  final VoidCallback onLike;

  // QuotePage({required this.quote});
  QuotePage({required this.quote, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            quote,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: onLike,
            child: Icon(
              Icons.favorite_border,
              size: 30.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}