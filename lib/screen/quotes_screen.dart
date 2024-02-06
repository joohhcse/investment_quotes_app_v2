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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: PageView.builder(
  //       itemCount: _quotes.length,
  //       itemBuilder: (context, index) {
  //         // print(index);   // index = 0 ~
  //         // int isLiked = DatabaseService.instance.getIsLikedById(index + 1);
  //         return QuotePage(
  //           quote: _quotes[index].quote.toString(),
  //           onLike: () async {
  //             // String strIsLiked = _quotes[index].isLiked.toString();
  //             // print('strIsLiked : ' + strIsLiked);  //false
  //
  //             if(!_quotes[index].isLiked) {   // favorite_list에 추가
  //               Favorite favorite = Favorite(
  //                 id: index,
  //                 quote: _quotes[index].quote.toString(),
  //                 date: DateTime.now(),
  //               );
  //
  //               print('[if] favorite.id >> ' + favorite.id.toString());
  //
  //               //Quote isLiked를 true로 업데이트
  //               Quote quote = Quote(
  //                 id: index,
  //                 quote: _quotes[index].quote.toString(),
  //                 isLiked: true,
  //               );
  //               print('updateQuoteById >>> ');
  //               await DatabaseService.instance.updateQuoteById(quote);
  //               print(quote.id.toString());
  //               print(quote.quote.toString());
  //               print(quote.isLiked.toString());
  //
  //               print('insertFavoriteQuote >>> ');
  //               await DatabaseService.instance.insertFavoriteQuote(favorite);
  //               print(favorite.id.toString());
  //               print(favorite.quote.toString());
  //               print(favorite.date.toString());
  //
  //               // setState 로 커밋하듯이 해야하나???
  //               // https://iosroid.tistory.com/44
  //               // var newMemberList = await _getMember();
  //               // setState(() {
  //               //   memberList = newMemberList;
  //               // });
  //             }
  //             else {  //favorite_list에서 제거
  //               print('[else] delete favorite.id >> ' + index.toString());
  //               await DatabaseService.instance.deleteFavoriteQuote(index);
  //             }
  //           },
  //         );
  //       },
  //       physics: BouncingScrollPhysics(),
  //     ),
  //   );
  // }

//try test 1
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: PageView.builder(
      itemCount: _quotes.length,
      itemBuilder: (context, index) {
        return FutureBuilder<void>(
          future: DatabaseService.instance.getQuoteById(index),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터 로딩 중
              return CircularProgressIndicator(); // 로딩 애니메이션
            } else if (snapshot.hasError) {
              // 에러 발생
              return Text('Error: ${snapshot.error}');
            } else {
              // 데이터 로딩 완료
              // int? isLiked = snapshot.data;

              return QuotePage(
                quote: _quotes[index].quote.toString(),
                onLike: () async {
                  print(_quotes[index].id.toString());
                  print(_quotes[index].quote.toString());
                  print(_quotes[index].isLiked.toString());

                  if(_quotes[index].isLiked == 0) {
                    Favorite favorite = Favorite(
                      id: _quotes[index].id,
                      quote: _quotes[index].quote.toString(),
                      date: DateTime.now(),
                    );
                    DatabaseService.instance.insertFavoriteQuote(favorite);
                    print('insertFavoriteQuote >> id : ' + _quotes[index].id.toString());

                    // Quote quote = Quote(
                    //   quote: _quotes[index].quote.toString(),
                    //   isLiked: true,
                    // );
                    DatabaseService.instance.updateQuoteIsLikedById(_quotes[index].id!, 1); // update 안됨

                  }
                  else {
                    DatabaseService.instance.deleteFavoriteQuote(_quotes[index].id!);
                    print('deleteFavoriteQuote >> id : ' + _quotes[index].id.toString());

                    // Quote quote = Quote(
                    //   quote: _quotes[index].quote.toString(),
                    //   isLiked: false,
                    // );
                    DatabaseService.instance.updateQuoteIsLikedById(_quotes[index].id!, 0); // update 안됨

                  }
                },
                // isLiked: isLiked == 1, // isLiked가 1이면 true, 아니면 false
              );
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