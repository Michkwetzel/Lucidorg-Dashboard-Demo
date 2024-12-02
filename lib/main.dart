import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/screens/AuthScreen.dart';

void main() {
  runApp(
    ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: AuthScreen(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
