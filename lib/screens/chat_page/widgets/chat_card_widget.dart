import 'package:connex_chat/screens/chat_page/widgets/chat_room_dialog.dart';
import 'package:connex_chat/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatCardWidget extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ChatCardWidget({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => ChatRoomDialog(),
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time, style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onFavoriteToggle,
                child: SvgPicture.asset(
                  isFavorite
                      ? 'assets/icons/bookmark-star-fill.svg'
                      : 'assets/icons/bookmark-star-outline.svg',
                  width: 25,
                  // height: 20,
                  color: bgColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
