import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_app/pages/calculator_tab.dart';

import '../pages/second_tab.dart';

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({
    super.key,
    required this.scaffoldKey,
    required this.state,
    required this.child,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          leading: DrawerButton(
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Text('First Tab')),
              Tab(icon: Text('Second Tab')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Placeholder(),
            SecondTab(
              state: state,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
