import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/setting_screen.dart';
import 'package:investment_quotes_app_v2/screen/favorite_list_screen.dart';
import 'package:investment_quotes_app_v2/screen/quotes_screen.dart';
import 'package:investment_quotes_app_v2/database/database_service.dart';
import 'package:investment_quotes_app_v2/model/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:investment_quotes_app_v2/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class HomeScreen extends StatefulWidget {
  // final bool isDarkMode;

  const HomeScreen({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  BannerAd? _bannerAd;

  //Flutter 앱에 AdMob 광고 추가 (Google공식문서)
  //https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter?hl=ko#0

  // 각 탭에 해당하는 화면들
  final List<Widget> _children = [
    QuotesScreen(),
    FavoriteListScreen(),
    SettingScreen()
  ];

  // 데이터베이스 초기화 및 데이터 로딩
  @override
  void initState() {
    super.initState();
    _loadThemeMode();

    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  late SharedPreferences _prefs;

  Future<void> _loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final String? savedThemeMode = _prefs.getString('themeMode');

    if(savedThemeMode == null) {
      HomeScreen.themeNotifier.value = ThemeMode.light;
    } else if(savedThemeMode == "ThemeMode.light") {
      HomeScreen.themeNotifier.value = ThemeMode.light;
    } else if(savedThemeMode == "ThemeMode.dark") {
      HomeScreen.themeNotifier.value = ThemeMode.dark;
    }

    print('home_screen _loadThemeMode()');
    print(savedThemeMode);

  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.setString('themeMode', themeMode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      // ValueListenableBuilder를 사용하여 themeNotifier의 변경을 감지하고 화면을 다시 그립니다.
      valueListenable: HomeScreen.themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          themeMode: themeMode, // MaterialApp의 테마 모드를 themeNotifier의 값으로 설정합니다.
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.sms_rounded),
                  label: '투자 명언',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: '즐겨찾기',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '설정',
                ),
              ],
            ),
            bottomSheet: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: bottomSheetContent(),
              // child: AdmobBanner(
              //   adUnitId: 'ca-app-pub-3940256099942544/6300978111',
              //   adSize: bannerSize!,
              //   listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
              //       handleEvent(event, args, 'Banner');
              //   },
              //   onBannerCreated: (AdmobBannerController controller) {
              //
              //   },
              // ),

            )
          ),
        );
      },
    );
  }

  //backup2
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       body: _children[_currentIndex],
  //       bottomNavigationBar: BottomNavigationBar(
  //         currentIndex: _currentIndex,
  //         onTap: onTabTapped,
  //         items: [
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.sms_rounded),
  //             label: '투자 명언',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.favorite),
  //             label: '즐겨찾기',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.settings),
  //             label: '설정',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  //backup
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // appBar: AppBar(
  //     //   title: Text('하단바 메뉴 예제'),
  //     // ),
  //     body: _children[_currentIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       currentIndex: _currentIndex,
  //       onTap: onTabTapped,
  //       items: [
  //         BottomNavigationBarItem(
  //           // icon: Icon(Icons.content_paste),
  //           // icon: Icon(Icons.turned_in),
  //           icon: Icon(Icons.sms_rounded),
  //           label: '투자 명언',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.favorite),
  //           label: '즐겨찾기',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.settings),
  //           label: '설정',
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget bottomSheetContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 기타 내용들...
        // AdMob 배너를 추가하는 부분
        if (_bannerAd != null)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          ),
        // 기타 내용들...
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // 앱이 종료될 때 SharedPreferences에 테마 모드를 저장
  @override
  void dispose() {
    _saveThemeMode(HomeScreen.themeNotifier.value);
    super.dispose();
  }
}
