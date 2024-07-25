import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'presentation/pages/input_user_info_screen.dart';

Future<void> main() async {
  await dotenv.load(); // .env 파일 로드
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
