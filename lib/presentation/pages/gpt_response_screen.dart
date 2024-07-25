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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset('asset/images/gpt_profile.png'),
              const SizedBox(height: 15),
              const Text(
                '취업운 GPT',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 25),
              if (gptResponse.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    border: Border.all(color: primary),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Text(
                    gptResponse,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
