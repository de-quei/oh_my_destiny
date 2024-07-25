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
                'You are an assistant that provides career fortune-telling. We will provide you with our name, our gender, our birthdate so you should provide our career fortune.'
          },
          {
            'role': 'user',
            'content':
                '넌 지금부터 명리학자야\n사람의 정보를 보고 사주를 봐주면 돼\n취업운을 볼거야\n\n이름 : $name\n생년월일 : $birthdate\n달력 : $calendar\n성별 : $gender\n\n내 정보야\n취업운을 알고 싶어\n\n답변 마지막에는 행운을 빕니다! (네잎클로버 이모티콘)으로 마무리해줘'
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
