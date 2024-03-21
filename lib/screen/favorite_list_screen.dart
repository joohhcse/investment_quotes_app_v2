import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/quotes_screen.dart';
import 'package:investment_quotes_app_v2/database/database_service.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';
import 'package:investment_quotes_app_v2/model/Favorite.dart';

import 'package:investment_quotes_app_v2/banner_ad_widget.dart';

class FavoriteListScreen extends StatefulWidget {
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

  }

  Future<void> _getFavoriteQuotes() async {
    final quotes = await DatabaseService.instance.getAllFavoriteQuotes();

    if (mounted) {
      setState(() => _favoriteQuotes = quotes);
    }
  }

  //add BannerAdWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BannerAdWidget(), // 광고 위젯 추가,
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
              itemCount: _favoriteQuotes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_favoriteQuotes[index].quote.toString()),
                  trailing: GestureDetector(
                    onTap: () async {
                      try {
                        await DatabaseService.instance.deleteFavoriteQuote(_favoriteQuotes[index].id!);
                        await DatabaseService.instance.updateQuoteIsLikedById(_favoriteQuotes[index].id!, 0);

                        //즉시 ListView에 반영해서 해당 index 제거
                        setState(() {
                          _favoriteQuotes.removeAt(index);
                        });
                      } catch (e) {
                        print("An error occurred: $e");
                      }
                    },
                    child: Icon(
                      Icons.delete_rounded,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),

        ],
      ),
    );
  }

}