import 'package:flutter/material.dart';

import '../../app/config/app_color.dart';

class InputUserInfoScreen extends StatefulWidget {
  const InputUserInfoScreen({super.key});

  @override
  State<InputUserInfoScreen> createState() => _InputUserInfoScreenState();
}

class _InputUserInfoScreenState extends State<InputUserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '취업할 수 있을까..?',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  children: [
                    _buildGPTProfile(context), // gpt 프로필 빌드
                    const SizedBox(height: 15),
                    _buildInfoContainer(context), // 설명 빌드
                    const SizedBox(height: 30),
                    Container(
                      child: Column(
                        children: [
                          const Text(
                            '이름',
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(height: 10),
                          TextField(
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      child: Column(
                        children: [
                          const Text(
                            '성별',
                            style: TextStyle(fontSize: 17),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.all(18),
                                    foregroundColor: secondary,
                                    side: BorderSide(color: stroke),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('남성'),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.all(18),
                                    foregroundColor: secondary,
                                    side: BorderSide(color: stroke),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('여성'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildDescription(context), // 개인정보 수집 용도 빌드
                  ],
                ),
              ),
            ),
          ),
          // TODO: Spacer 쓰고싶은딩 ㅠ
          // Elevated Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.all(17),
                  // 기본 적용된 Radius를 사용자 지정으로 변환
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  '사주보기',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// gpt 프로필
Widget _buildGPTProfile(BuildContext context) {
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
        )
      ],
    ),
  );
}

// 설명 컨테이너
Widget _buildInfoContainer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    decoration: BoxDecoration(
      color: primary,
      borderRadius: const BorderRadius.only(
        // 말풍선 모양을 위한 Radius
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    ),
    child: const Text(
      '안녕! 나는 실리콘밸리 gpt야!\n취업에 대한 걱정이 있는 것 같네?\n걱정하지마 내가 다 봐줄게!\n일단 아래 정보를 다 작성해줄래?',
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

// 개인정보 수집 용도 설명
Widget _buildDescription(BuildContext context) {
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
