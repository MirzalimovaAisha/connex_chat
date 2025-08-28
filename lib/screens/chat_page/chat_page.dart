import 'dart:convert';
import 'package:connex_chat/screens/chat_page/widgets/create_chat_dialog.dart';
import 'package:connex_chat/screens/chat_page/widgets/chat_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connex_chat/widgets/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> chatData = [];
  String selectedTab = '사내 전체 공지';
  Set<String> favoriteNames = {}; // 즐겨찾기한 사원 이름 저장

  @override
  void initState() {
    super.initState();
    loadChatData();
    loadFavorites();
  }

  Future<void> loadChatData() async {
    final String response = await rootBundle.loadString(
      'assets/json/채팅방_대화_내용_data.json',
    );
    final data = await json.decode(response);
    setState(() {
      chatData = data;
    });
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList("favorites") ?? [];
    setState(() {
      favoriteNames = savedList.toSet();
    });
  }

  Future<void> toggleFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteNames.contains(name)) {
        favoriteNames.remove(name);
      } else {
        favoriteNames.add(name);
      }
    });
    await prefs.setStringList("favorites", favoriteNames.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          // ===== 헤더 =====
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '채팅방 목록',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreateChatDialog(),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/chat-plus-outline.svg',
                    color: Colors.white,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),

          // ===== 본문 =====
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 탭 선택
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
                    child: Row(
                      children: [
                        _buildTab("즐겨찾기"),
                        const SizedBox(width: 15),
                        _buildTab("사내 전체 공지"),
                        const SizedBox(width: 15),
                        _buildTab("개발팀"),
                      ],
                    ),
                  ),

                  // 채팅 리스트
                  Expanded(child: _allChats())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String tabName) {
    final bool isSelected = selectedTab == tabName;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tabName;
        });
      },
      child: Text(
        tabName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: isSelected ? bgColor : Colors.grey,
        ),
      ),
    );
  }

  /// ====== 채팅 리스트 ======
  Widget _allChats() {
    if (selectedTab == "개발팀") {
      // 개발팀 탭: 빈 화면
      return const Center(child: Text(""));
    }
    List<dynamic> filteredData;

    if (selectedTab == "즐겨찾기") {
      // 즐겨찾기 탭: favoriteNames에 포함된 것만
      filteredData = chatData.where((item) {
        return favoriteNames.contains(item["사원 이름"] ?? "");
      }).toList();
    } else {
      // 사내 전체 공지 탭: 모든 데이터
      filteredData = chatData;
    }

    if (filteredData.isEmpty) {
      return const Expanded(
        child: Center(child: Text("데이터 없음")),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final item = filteredData[index];
          final name = item["사원 이름"] ?? "알 수 없음";

          return ChatCardWidget(
            name: name,
            message: item["대화 내용"] ?? "",
            time: item["대화 전송 시간"] ?? "",
            isFavorite: favoriteNames.contains(name),
            onFavoriteToggle: () => toggleFavorite(name),
          );
        },
      ),
    );
  }

}
