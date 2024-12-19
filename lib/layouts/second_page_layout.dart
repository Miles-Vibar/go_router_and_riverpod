import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondPageLayout extends StatelessWidget {
  const SecondPageLayout({
    super.key,
    required this.scaffoldKey,
    required this.child,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
        leading: DrawerButton(
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: child.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Second',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Third',
          ),
        ],
        onTap: (value) => child.goBranch(value),
      ),
    );
  }
}
