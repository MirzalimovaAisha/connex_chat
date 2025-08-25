import 'package:connex_chat/widgets/button_widget.dart';
import 'package:connex_chat/widgets/color.dart';
import 'package:connex_chat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/simbol-color.svg',
                        color: Colors.white,
                        width: 35,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Connex Chat',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    '안녕하세요!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Connex Chat과 함께 오늘도 활기찬 하루되세요',
                    style: TextStyle(fontSize: 17, color: Colors.white70),
                  ),
                ],
              ),
            ),


            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: bgColor,
                    ),
                  ),
                  SizedBox(height: 20),

                  CustomTextField(
                    controller: _emailController,
                    placeholder: '이메일을 입력해주세요',
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: _passwordController,
                    placeholder: '비밀번호를 입력해주세요',
                    obscureText: true,
                  ),

                  SizedBox(height: 183),

                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/bottom_navi');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: bgColor,
                          width: 1
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bgColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('회원가입 기능이 준비중입니다.'))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: bgColor,
                      ),
                      child: Text(
                        '회원가입 하러가기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
