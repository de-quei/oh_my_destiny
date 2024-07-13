import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'presentation/pages/input_user_info_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 마크를 숨깁니다.
      getPages: [
        GetPage(
            name: '/input_user_info', page: () => const InputUserInfoScreen()),
      ],
      initialRoute: '/input_user_info',
    );
  }
}
