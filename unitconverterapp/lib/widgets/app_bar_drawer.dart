import 'package:flutter/material.dart';

class AppDrawerBar extends StatelessWidget {
  const AppDrawerBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 15,
      title: const Text(
        "What you want to convert?",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
