import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/favorite_list_screen.dart';
import 'package:investment_quotes_app_v2/database/database_service.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';
import 'package:investment_quotes_app_v2/model/Favorite.dart';

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
    _getQuotes();
    //_quotes.shuffle();  // _quotes.shuffle() 적용안됨 
  }

  Future<void> _getQuotes() async {
    final quotes = await DatabaseService.instance.getAllQuotes();
    if (mounted) {
      setState(() => _quotes = quotes);
    }
  }

  //backup //20240204 : futureBuilder로 바꺼야할듯 : 비동기를 사용해야하니까
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _quotes.length,
        itemBuilder: (context, index) {
          // print(index);   // index = 0 ~
          // int isLiked = DatabaseService.instance.getIsLikedById(index + 1);
          return QuotePage(
            quote: _quotes[index].quote.toString(),
            onLike: () async {
              // String strIsLiked = _quotes[index].isLiked.toString();
              // print('strIsLiked : ' + strIsLiked);  //false

              if(!_quotes[index].isLiked) {   // favorite_list에 추가
                Favorite favorite = Favorite(
                  id: index,
                  quote: _quotes[index].quote.toString(),
                  date: DateTime.now(),
                );

                print('[if] favorite.id >> ' + favorite.id.toString());

                //Quote isLiked를 true로 업데이트
                Quote quote = Quote(
                  id: index,
                  quote: _quotes[index].quote.toString(),
                  isLiked: true,
                );
                print('updateQuoteById >>> ');
                await DatabaseService.instance.updateQuoteById(quote);
                print(quote.id.toString());
                print(quote.quote.toString());
                print(quote.isLiked.toString());

                print('insertFavoriteQuote >>> ');
                await DatabaseService.instance.insertFavoriteQuote(favorite);
                print(favorite.id.toString());
                print(favorite.quote.toString());
                print(favorite.date.toString());

                // setState 로 커밋하듯이 해야하나???
                // https://iosroid.tistory.com/44
                // var newMemberList = await _getMember();
                // setState(() {
                //   memberList = newMemberList;
                // });
              }
              else {  //favorite_list에서 제거
                print('[else] delete favorite.id >> ' + index.toString());
                await DatabaseService.instance.deleteFavoriteQuote(index);
              }
            },
          );
        },
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  //try test2
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: PageView.builder(
  //       itemCount: _quotes.length,
  //       itemBuilder: (context, index) {
  //         int currentId = index;
  //         print(currentId);
  //         return QuotePage(
  //           quote: _quotes[index].quote.toString(),
  //           onLike: () async {
  //             // if(!isLiked) {
  //             //   Favorite favorite = Favorite(
  //             //     // id: index,
  //             //     quote: _quotes[index].quote.toString(),
  //             //     date: DateTime.now(),
  //             //   );
  //             //   await DatabaseService.instance.insertFavoriteQuote(favorite);
  //             }
  //           },
  //         );
  //       },
  //       physics: BouncingScrollPhysics(),
  //     ),
  //   );
  // }

  //try test 1
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: PageView.builder(
  //       itemCount: _quotes.length,
  //       itemBuilder: (context, index) {
  //         return FutureBuilder<int?>(
  //           future: DatabaseService.instance.getIsLikedById(index),
  //           builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
  //             print('return FutureBuilder<int?>(');
  //             print(index);
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               // 데이터 로딩 중
  //               return CircularProgressIndicator();
  //             } else if (snapshot.hasError) {
  //               // 에러 발생
  //               return Text('Error: ${snapshot.error}');
  //             } else {
  //               // 데이터 로딩 완료
  //               int? isLiked = snapshot.data;
  //
  //               return QuotePage(
  //                 quote: _quotes[index].quote.toString(),
  //                 onLike: () async {
  //                   if (isLiked != null && isLiked == 1) {
  //                     // 이미 좋아요를 누른 상태일 때의 처리
  //                     // TODO: 추가적인 로직 구현
  //                     print('이미 좋아요를 누른 상태일 때의 처리');
  //                   } else {
  //                     // 좋아요를 누르지 않은 상태일 때의 처리
  //                     // TODO: 추가적인 로직 구현
  //                     print('좋아요를 누르지 않은 상태일 때의 처리');
  //                   }
  //                 },
  //                 isLiked: isLiked == 1, // isLiked가 1이면 true, 아니면 false
  //               );
  //             }
  //           },
  //         );
  //
  //       },
  //       physics: BouncingScrollPhysics(),
  //     ),
  //   );
  // }





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
  // QuotePage({required this.quote, required this.onLike, required bool isLiked});
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
              // isLiked ? Icons.favorite : Icons.favorite_border,
              // size: 30.0,
              // color: isLiked ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }
}