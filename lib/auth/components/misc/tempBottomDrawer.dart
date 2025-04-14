import 'package:flutter/material.dart';

class CustomDrawerController {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;

  CustomDrawerController({required this.scaffoldKey, required this.context});

  void showTemporaryDrawer({
    required String title,
    required String content,
    Duration duration = const Duration(seconds: 2),
  }) {
    scaffoldKey.currentState?.openDrawer();

    Future.delayed(duration, () {
      if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
        Navigator.of(context).pop();
      }
    });
  }
}

class TempBottonDrawer extends StatefulWidget {
  @override
  TempBottonDrawerState createState() => TempBottonDrawerState();
}

class TempBottonDrawerState extends State<TempBottonDrawer> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late CustomDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _drawerController = CustomDrawerController(scaffoldKey: _scaffoldKey, context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Customizable Drawer')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _drawerController.showTemporaryDrawer(
            title: 'Custom Drawer',
            content: 'This is a temporary drawer with custom text',
          ),
          child: const Text('Show Drawer'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Custom Drawer Title'),
            ),
            ListTile(
              title: Text('Custom Drawer Content'),
            ),
          ],
        ),
      ),
    );
  }
}
