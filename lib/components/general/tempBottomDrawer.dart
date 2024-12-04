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
  _TempBottonDrawerState createState() => _TempBottonDrawerState();
}

class _TempBottonDrawerState extends State<TempBottonDrawer> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late CustomDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _drawerController = CustomDrawerController(scaffoldKey: _scaffoldKey, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Customizable Drawer')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _drawerController.showTemporaryDrawer(
            title: 'Custom Drawer',
            content: 'This is a temporary drawer with custom text',
          ),
          child: Text('Show Drawer'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Custom Drawer Title'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
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
