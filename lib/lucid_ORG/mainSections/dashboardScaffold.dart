import 'package:flutter/material.dart';

import 'package:platform_front/navBar/navigationBar.dart';

class Dashboardscaffold extends StatelessWidget {
  final Widget body;
  const Dashboardscaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NavBar(),
            Flexible(child: body),
          ],
        ),
      ),
    );
  }
}
