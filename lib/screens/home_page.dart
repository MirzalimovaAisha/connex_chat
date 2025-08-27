import 'dart:convert';
import 'package:connex_chat/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  List<dynamic> chatRooms = [];
  List<dynamic> employees = [];

  @override
  void initState() {
    super.initState();
    loadChatRooms();
    loadEmployees();
  }

  Future<void> loadChatRooms() async {
    final String response = await rootBundle.loadString(
      'assets/json/채팅방_data.json',
    );
    setState(() {
      chatRooms = json.decode(response);
    });
  }

  Future<void> loadEmployees() async {
    final String response = await rootBundle.loadString(
      'assets/json/사원_목록_data.json',
    );
    setState(() {
      employees = json.decode(response);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/users/employee1.jpg'),
                ),
                SizedBox(width: 10),
                Text(
                  'Competitor1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 5),
                Text('님', style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 읽지 않은 대화 카드 리스트 (JSON 기반)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '읽지 않은 대화가 ${chatRooms.length}개 있어요!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 110,
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          itemCount: chatRooms.length,
                          itemBuilder: (context, index) {
                            final room = chatRooms[index];
                            return Container(
                              width: 170,
                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: bgColor.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.asset(
                                            'assets/images/users/employee3.jpg',
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.asset(
                                            'assets/images/users/employee2.jpg',
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          'assets/images/users/employee1.jpg',
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    room["채팅방 이름"] ?? "",
                                    style: TextStyle(
                                      color: bgColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    room["마지막 대화 내용"] ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  // 사원 목록
                  Text(
                    '사원 목록',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        final employee = employees[index];
                        return ListTile(
                          contentPadding: EdgeInsets.only(bottom: 15),
                          minTileHeight: 60,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/images/users/${employee['사원 프로필']}.jpg",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(employee['사원 이름']),
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
