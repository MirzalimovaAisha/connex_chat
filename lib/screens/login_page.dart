import 'package:connex_chat/widgets/color.dart';
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

  // ✅ 유효성 검사 및 로그인 처리
  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || !email.contains("@") || email.contains(" ")) {
      _showMessage("올바른 이메일을 입력해주세요.");
      return;
    }
    if (password.isEmpty || password.length < 4) {
      _showMessage("비밀번호는 4자 이상 입력해주세요.");
      return;
    }

    // ✅ REST API 로그인 (여기선 Mock)
    bool loginSuccess = await fakeLoginApi(email, password);

    if (loginSuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);

      if (mounted) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomePage()),
        // );
      }
    } else {
      _showMessage("로그인 실패. 다시 시도해주세요.");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // ✅ Mock API (실제로는 REST API 연동 필요)
  Future<bool> fakeLoginApi(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // 네트워크 대기 시뮬레이션
    return email == "test@test.com" && password == "1234";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(30),
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
                      SizedBox(width: 10,),
                      Text(
                        'Connex Chat',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text('안녕하세요!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),),
                  Text(
                    'Connex Chat과 함께 오늘도 활기찬 하루되세요',
                    style: TextStyle(fontSize: 17, color: Colors.white70),
                  )
                ],
              ),
            ),

            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: bgColor),),
                  SizedBox(height: 20,),

                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.grey)
                    )
                  )
                ],
              ),
            )

            
          ],
        ),
      ),
    );
  }
}






















