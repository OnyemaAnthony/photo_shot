import 'package:flutter/material.dart';

class ApBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PhotoShot',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
