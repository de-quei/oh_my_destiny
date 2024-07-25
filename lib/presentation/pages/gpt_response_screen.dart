import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_color.dart';

class GptResponseScreen extends StatelessWidget {
  const GptResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String gptResponse = Get.arguments; // Get the GPT response

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '사주 결과',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (gptResponse
                .isNotEmpty) // Display response only if it's not empty
              Text(
                gptResponse,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
