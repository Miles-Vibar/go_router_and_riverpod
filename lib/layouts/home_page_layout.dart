import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_app/pages/first_tab.dart';
import 'package:routing_app/providers/keyboard_listener_provider.dart';

import '../pages/second_tab.dart';

class HomePageLayout extends ConsumerWidget {
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
  Widget build(BuildContext context, ref) {
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
              Tab(icon: Text('Keyboard Presses')),
              Tab(icon: Text('GoRoute')),
            ],
          ),
          actions: [
            IconButton(onPressed: () => ref.read(keyboardListenerNotifierProvider.notifier).deleteAll(), icon: const Icon(Icons.delete))
          ],
        ),
        body: TabBarView(
          children: [
            const FirstTab(),
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
