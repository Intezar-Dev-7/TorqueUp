import 'package:flutter/material.dart';

class OtherLoginOptions extends StatelessWidget {
  const OtherLoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            'assets/general_icons/google.png',
            height: 30,
            width: 30,
          ),
        ),

        GestureDetector(
          onTap: () {},
          child: Image.asset(
            'assets/general_icons/apple.png',
            height: 30,
            width: 30,
          ),
        ),
      ],
    );
  }
}
