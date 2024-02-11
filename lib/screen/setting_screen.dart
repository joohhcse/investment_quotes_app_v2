import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/quotes_screen.dart';
import 'package:investment_quotes_app_v2/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDarkMode = false;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => SettingState();
}

class SettingState extends State<SettingScreen> {
  int selectedOption = 0; // 초기 선택된 옵션 ?

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  late SharedPreferences _prefs;

  Future<void> _loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final String? savedThemeMode = _prefs.getString('themeMode');

    if(savedThemeMode == null) {
      HomeScreen.themeNotifier.value = ThemeMode.light;
      isDarkMode = false;
    } else if(savedThemeMode == "ThemeMode.light") {
      HomeScreen.themeNotifier.value = ThemeMode.light;
      isDarkMode = false;
    } else if(savedThemeMode == "ThemeMode.dark") {
      HomeScreen.themeNotifier.value = ThemeMode.dark;
      isDarkMode = true;
    }

    print('setting >>> _load :: ');
    print(isDarkMode);

  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.setString('themeMode', themeMode.toString());

    print('setting >> save >>>>');
    print(themeMode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('다크 모드'),
                // Switch(
                //   value: false, // 여기에 실제 설정값을 넣어주세요.
                //   onChanged: (value) {
                //     setState(() {
                //       value = !value;
                //     });
                //   },
                // ),
                CupertinoSwitch(
                    value: isDarkMode,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (bool? value) {
                      setState(() {
                        isDarkMode = value ?? false;  //null이면 false입력

                        if(isDarkMode == true) {
                          HomeScreen.themeNotifier.value = ThemeMode.dark;

                          _saveThemeMode(ThemeMode.dark);
                        }
                        else {
                          HomeScreen.themeNotifier.value = ThemeMode.light;

                          _saveThemeMode(ThemeMode.light);
                        }

                      });
                    }
                )
              ],
            ),
            SizedBox(height: 16.0),
            // 추가적인 설정 항목들을 원하는 만큼 추가할 수 있습니다.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = 1;
                        });
                      },
                    ),
                    Text('옵션1'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = 2;
                        });
                      },
                    ),
                    Text('옵션 2'),
                  ],
                ),
                // Add more Radio buttons as needed
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}