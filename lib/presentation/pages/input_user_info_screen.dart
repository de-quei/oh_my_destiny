// lib/presentation/pages/input_user_info_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api_service.dart';
import '../../app/config/app_color.dart';

class InputUserInfoScreen extends StatefulWidget {
  const InputUserInfoScreen({super.key});

  @override
  State<InputUserInfoScreen> createState() => _InputUserInfoScreenState();
}

class _InputUserInfoScreenState extends State<InputUserInfoScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  String? _selectedGender;
  String? _selectedCalendar;
  String? _gptResponse;

  final ApiService _apiService = ApiService(); // ApiService 인스턴스 생성

  @override
  void dispose() {
    _usernameController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  void _onGenderSelected(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  void _onCalendarSelected(String calendar) {
    setState(() {
      _selectedCalendar = calendar;
    });
  }

  Future<void> _submitUserInfo() async {
    final name = _usernameController.text;
    final birthdate = _birthdateController.text;
    final gender = _selectedGender;
    final calendar = _selectedCalendar;

    // 입력 값이 비어있는지 검사
    if (name.isEmpty ||
        birthdate.isEmpty ||
        gender == null ||
        calendar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 정보를 입력해주세요.')),
      );
      return;
    }

    // Response
    try {
      final response =
          await _apiService.fetchGptResponse(name, birthdate, gender, calendar);
      Get.toNamed('/gpt_response',
          arguments: response); // Navigate with GPT response
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GPT API 호출에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '취업할 수 있을까..?',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            children: [
              const SizedBox(height: 15),
              gptProfile(context), // 소개말
              const SizedBox(height: 30),
              // 사용자 정보 입력
              UserInfoInput(
                controller: _usernameController,
                onGenderSelected: _onGenderSelected,
                birthdateController: _birthdateController,
                onCalenderSelected: _onCalendarSelected,
              ),
              const SizedBox(height: 20),
              description(context), // 개인정보 수집 용도 설명
              const SizedBox(height: 20),
              // 제출 버튼
              Align(
                alignment: Alignment.bottomCenter,
                child: SubmitButton(
                  onSubmit: _submitUserInfo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// gpt 프로필
Widget gptProfile(BuildContext context) {
  return Center(
    child: Column(
      children: [
        Image.asset('asset/images/gpt_profile.png'),
        const SizedBox(height: 15),
        const Text(
          '취업운 GPT',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '#취업운 #성공운',
          style: TextStyle(color: secondary),
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: const Text(
            '안녕하세요?\n저는 취업운을 알려주는 인공지능입니다.\n취업에 대한 걱정이 있으시군요...\n걱정하지 마세요! 제가 취업운을 봐드릴게요 😳\n먼저 아래 정보를 다 작성해주시겠어요?',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

// 유저정보 입력
class UserInfoInput extends StatefulWidget {
  final TextEditingController controller; // 사용자 이름 컨트롤러
  final ValueChanged<String> onGenderSelected;
  final TextEditingController birthdateController; // 사용자 생년월일 컨트롤러
  final ValueChanged<String> onCalenderSelected;

  const UserInfoInput({
    super.key,
    required this.controller,
    required this.onGenderSelected,
    required this.birthdateController,
    required this.onCalenderSelected,
  });

  @override
  State<UserInfoInput> createState() => _UserInfoInputState();
}

class _UserInfoInputState extends State<UserInfoInput> {
  String? selectedGender; // 사용자 성별 선택
  String? selectedCalendar; // 사용자 생년월일 선택

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 이름 입력
        const Text(
          '이름',
          style: TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: '김미림',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: stroke,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // 성별 선택
        const Text(
          '성별',
          style: TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            genderButton(context, '남성'),
            genderButton(context, '여성'),
          ],
        ),
        const SizedBox(height: 20),
        // 생년월일 입력
        const Text(
          '생년월일',
          style: TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3.2,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: stroke,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: '양력', child: Text('양력')),
                  DropdownMenuItem(value: '음력', child: Text('음력')),
                  DropdownMenuItem(value: '음력(윤달)', child: Text('음력(윤달)'))
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCalendar = value;
                  });
                  widget.onCalenderSelected(value!);
                },
                hint: const Text('양력'),
                value: selectedCalendar,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.8,
              child: TextField(
                controller: widget.birthdateController,
                decoration: InputDecoration(
                  hintText: 'YYYY-MM-DD',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: stroke,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 성별 선택 버튼
  Widget genderButton(BuildContext context, String gender) {
    bool isSelected = selectedGender == gender;
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.3,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          foregroundColor: isSelected ? Colors.black : secondary,
          side: BorderSide(color: isSelected ? primary : stroke),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedGender = gender;
          });
          widget.onGenderSelected(gender);
        },
        child: Text(
          gender,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// 개인정보 활용 안내
Widget description(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(15)),
    child: const Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.favorite_border_rounded,
              color: Color(0xFF999999),
              size: 19,
            ),
            SizedBox(width: 5),
            Text(
              '안심하세요!',
              style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 7),
        Text(
          '내 팔자야에서 수집한 개인정보는 내 팔자야 내에서 운세 서비스를 제공하기 위한 용도 이외에는 사용되지 않습니다.',
          style: TextStyle(fontSize: 13, color: Color(0xFFA0A0A0)),
        )
      ],
    ),
  );
}

// 제출 버튼
class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const SubmitButton({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onSubmit,
        child: const Text(
          '사주보기',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
