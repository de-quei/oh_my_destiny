// lib/services/api_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  Future<String?> fetchGptResponse(
      String name, String birthdate, String gender, String calendar) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are an assistant that provides career fortune-telling.'
          },
          {
            'role': 'user',
            'content':
                '이름: $name\n성별: $gender\n생년월일: $birthdate\n달력: $calendar\n\n취업운을 알고 싶습니다.'
          }
        ],
        'max_tokens': 4096,
      }),
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(
          'Failed to call GPT API. Status code: ${response.statusCode}');
    }
  }
}
