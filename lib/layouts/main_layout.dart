import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    required this.scaffoldKey,
    required this.child,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Builder(builder: (context) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                leading: const Icon(Icons.home),
                onTap: () {
                  context.goNamed('/home');
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                  title: const Text('Second Page'),
                  leading: const Icon(Icons.inbox),
                  onTap: () {
                    context.goNamed('/a');
                    Scaffold.of(context).closeDrawer();
                  }),
              ListTile(
                title: const Text('Riverpod'),
                leading: const Icon(Icons.info),
                onTap: () {
                  context.goNamed('/thirdPage');
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ],
          );
        }),
      ),
      body: child,
    );
  }
}
