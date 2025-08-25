import 'dart:convert';
import 'package:connex_chat/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  List<dynamic> employees = [];

  @override
  void initState() {
    super.initState();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    final String response = await rootBundle.loadString(
      'assets/json/사원_목록_data.json',
    );
    final data = json.decode(response);
    setState(() {
      employees = data;
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
                  backgroundImage: AssetImage(
                    'assets/images/users/employee1.jpg',
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Competitor1',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                ),
                SizedBox(width: 5),
                Text('님', style: TextStyle(fontSize: 18,color: Colors.white),),
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
                        Text(
                          '사원 목록',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: employees.length,
                            itemBuilder: (context, index) {
                              final employee = employees[index];
                              return ListTile(
                                contentPadding: EdgeInsets.only(bottom: 20),
                                minTileHeight: 70,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  child: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.white, // 왼쪽은 그대로
                                          Colors.transparent, // 오른쪽으로 갈수록 투명
                                        ],
                                        stops: [0.6, 1], // 70% 이후부터 투명하게
                                      ).createShader(bounds);
                                    },
                                    blendMode: BlendMode.dstIn, // 이미지와 마스크를 합성
                                    child: Image.asset(
                                      "assets/images/users/${employee['사원 프로필']}.jpg",
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
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
