import 'package:connex_chat/screens/chat_page/chat_page.dart';
import 'package:connex_chat/screens/home_page.dart';
import 'package:connex_chat/screens/profile_page.dart';
import 'package:connex_chat/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({super.key});

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  int _selectedIndex = 0;

  final List<String> _icons = [
    'assets/icons/home-outline.svg',
    'assets/icons/chat-dots-outline.svg',
    'assets/icons/person-outline.svg',
  ];

  final List<String> _iconsActive = [
    'assets/icons/home-fill.svg',
    'assets/icons/chat-dots-fill.svg',
    'assets/icons/person-fill.svg',
  ];

  final List<String> _labels = ['Home', 'Chat', 'Profile'];

  static const List<Widget> _widgetOptions = [
    HomePage(),
    ChatPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 2)
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            bool isSelected = index == _selectedIndex;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    isSelected ? _iconsActive[index] : _icons[index],
                    width: 28,
                    height: 28,
                    color: bgColor,
                  ),
                  Text(
                    _labels[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: bgColor
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
