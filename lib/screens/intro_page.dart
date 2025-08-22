import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;

  late AnimationController _descController;
  late Animation<double> _descOpacity;

  late AnimationController _buttonController;
  late Animation<double> _buttonOpacity;

  late AnimationController _buttonBgController;
  late Animation<double> _buttonBgOpacity;

  late AnimationController _arrowController;
  late Animation<Offset> _arrowOffset;

  String _title = "";
  final String _fullTitle = "Connex Chat";

  @override
  void initState() {
    super.initState();

    // 로고 애니메이션
    _logoController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _logoController, curve: Curves.easeIn));
    _logoRotation = Tween<double>(begin: pi / 2, end: 0).animate(
        CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // 설명 Fade
    _descController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _descOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _descController, curve: Curves.easeIn));

    // 하얀 원 Fade + Slide
    _buttonController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _buttonOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeIn));

    // 배경 Fade + Slide
    _buttonBgController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _buttonBgOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _buttonBgController, curve: Curves.easeIn));

    // 하얀 원 움직임
    _arrowController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _arrowOffset = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.1))
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40, // 위로 이동
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(Offset(0, -0.15)), // 잠시 멈춤
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset(0, -0.15), end: Offset(0, 0))
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 40, // 내려오기
      ),
    ]).animate(_arrowController);

    _startSequence();
  }

  Future<void> _startSequence() async {
    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    // 타이틀 타이핑
    for (int i = 0; i < _fullTitle.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      setState(() {
        _title = _fullTitle.substring(0, i + 1);
      });
    }

    // 설명 Fade
    _descController.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    // 하얀 원 나타남
    await _buttonController.forward();

    // 배경 나타남
    await _buttonBgController.forward();

    // 배경 Fade 완료 후 원 움직임 시작
    _arrowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _descController.dispose();
    _buttonController.dispose();
    _buttonBgController.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D2FD4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // 로고 + 타이틀
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _logoRotation.value,
                      child: Transform.scale(scale: _logoScale.value, child: child),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/images/simbol-color.svg',
                    color: Colors.white,
                    width: 50,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 230,
                  child: Text(
                    _title,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            FadeTransition(
              opacity: _descOpacity,
              child: const Text(
                "언제 어디서든 안정적인 근무 환경을 위해",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            const Spacer(),

            // NEXT 버튼
            Stack(
              alignment: Alignment.center,
              children: [
                // 배경
                FadeTransition(
                  opacity: _buttonBgOpacity,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 90),
                      height: 150,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [Color(0x10FFFFFF), Color(0x6CE4DBFF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    child: Column(
                      children: [
                        Icon(Icons.keyboard_arrow_up, size: 30, color: Colors.white54,),
                        Icon(Icons.keyboard_arrow_up, size: 30, color: Colors.white),
                      ],
                    ),
                    ),
                ),

                // 하얀 원
                SlideTransition(
                  position: _arrowOffset,
                  child: FadeTransition(
                    opacity: _buttonOpacity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: const Center(
                          child: Text(
                            "NEXT",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5D2FD4)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
