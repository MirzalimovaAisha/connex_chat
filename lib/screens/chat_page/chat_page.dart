import 'dart:convert';
import 'package:connex_chat/screens/chat_page/create_chat_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connex_chat/widgets/color.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> chatData = [];

  @override
  void initState() {
    super.initState();
    loadChatData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          // 헤더
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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

          // 본문
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
                  // 섹션 탭 리스트 (예시: 사내 전체 공지, 개발팀 등)
                  Padding(
                    padding: const EdgeInsets.fromLTRB( 30, 30, 20, 0),
                    child: Row(
                      children: [
                        Text(
                          '사내 전체 공지',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: bgColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          '개발팀',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 채팅방 카드 리스트
                  Expanded(
                    child: ListView.builder(
                      itemCount: chatData.length,
                      itemBuilder: (context, index) {
                        final item = chatData[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 30), // 카드 간격
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20), // 둥글게
                            boxShadow: [
                              BoxShadow(
                                color: bgColor.withOpacity(0.4),
                                blurRadius: 8 ,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical:0),
                            title: Text(
                              item["사원 이름"] ?? "알 수 없음",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              item["대화 내용"] ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13, ),
                            ),
                            trailing: Text(
                              item["대화 전송 시간"] ?? "",
                              style: const TextStyle(fontSize: 13, ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
