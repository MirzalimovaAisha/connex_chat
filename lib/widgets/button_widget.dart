import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final TextStyle textStyle;
  final ButtonStyle buttonStyle;
  final String text;
  const ButtonWidget({super.key, required this.text, required this.textStyle, required this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){},
        style: buttonStyle,
        child: Text(text, style: textStyle,),
      ),
    );
  }
}
