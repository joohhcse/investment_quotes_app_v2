import 'package:flutter/material.dart';
import 'package:investment_quotes_app_v2/screen/quotes_screen.dart';
import 'package:investment_quotes_app_v2/screen/home_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => SettingState();
}

class SettingState extends State<SettingScreen> {
  int selectedOption = 0; // 초기 선택된 옵션 ?

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('푸시 알림'),
                Switch(
                  value: true, // 여기에 실제 설정값을 넣어주세요.
                  onChanged: (value) {
                    // 설정값 변경 로직을 넣어주세요.
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('다크 모드'),
                Switch(
                  value: false, // 여기에 실제 설정값을 넣어주세요.
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                ),
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
                    Text('옵션 1'),
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