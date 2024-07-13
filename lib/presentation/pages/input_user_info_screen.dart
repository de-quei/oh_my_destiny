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
      body: Text(
        'Hello, Flutter!',
        style: TextStyle(color: primary),
      ),
    );
  }
}
