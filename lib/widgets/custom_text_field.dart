import 'package:connex_chat/widgets/color.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String placeholder;
  final TextInputType? inputType;
  final bool? obscureText;

  const CustomTextField({super.key, this.controller, required this.placeholder, this.inputType, this.obscureText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) => setState(() => _hasFocus = focus),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        width: double.infinity,
        height: 73,
        decoration: BoxDecoration(
          border: Border.all(
            color: _hasFocus ? bgColor : Colors.grey,
            width: 2,
          ),
          boxShadow: _hasFocus
              ? [
            BoxShadow(
              color: bgColor.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ]
              : [],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.placeholder, style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
              SizedBox(height: 4,),
              TextField(
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
                controller: widget.controller,
                keyboardType: widget.inputType,
                obscureText: widget.obscureText ?? false,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

