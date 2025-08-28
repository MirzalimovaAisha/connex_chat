import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connex_chat/widgets/color.dart';

class ChatRoomDialog extends StatelessWidget {

  const ChatRoomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20), // 좌우 여백
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 닫기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "채팅방 이름",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            GestureDetector(
              child: Text('채팅방 정보 수정', style: TextStyle(color: Colors.black, fontSize: 15,)),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              child: Text('나가기', style: TextStyle(color: Colors.black, fontSize: 15,)),
            )



          ],
        ),
      ),
    );
  }
}
