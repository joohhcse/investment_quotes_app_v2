import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/home_screen.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  //flutter_windows_3.3.5-stable
  //https://github.com/MarcusNg/flutter_sqflite_todos
  runApp(
      MaterialApp(
        home: HomeScreen(),
      )
  );
}
