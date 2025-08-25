import 'package:connex_chat/widgets/color.dart';
import 'package:connex_chat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CreateChatDialog extends StatelessWidget {
  const CreateChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20), // 좌우 여백
      child: Container(
        padding: const EdgeInsets.fromLTRB( 20, 10, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 닫기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "채팅방 생성하기",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 섹션 이름 입력 필드
            CustomTextField(placeholder: '섹션 이름을 입력해주세요'),
            const SizedBox(height: 15),

            // 채팅방 이름 입력 필드
            CustomTextField(placeholder: '채팅방 이름을 입력해주세요'),
            const SizedBox(height: 20),

            // TODO: 사원 카드 리스트 추가 가능

            const SizedBox(height: 20),

            // 생성하기 버튼
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor,
                minimumSize: const Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "생성하기",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
