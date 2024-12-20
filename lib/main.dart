import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_app/layouts/main_layout.dart';
import 'package:routing_app/layouts/home_page_layout.dart';
import 'package:routing_app/layouts/second_page_layout.dart';
import 'package:routing_app/layouts/third_page_layout.dart';
import 'package:routing_app/pages/second_page_first_screen.dart';
import 'package:routing_app/pages/second_page_second_screen.dart';
import 'package:routing_app/pages/second_page_third_screen.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(480, 1024),
      center: true,
      minimumSize: Size(480, 1024),
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(elevation: 2)),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        initialLocation: '/thirdPage',
        routes: [
          ShellRoute(
            routes: [
              ShellRoute(
                routes: [
                  GoRoute(
                    path: '/home',
                    name: '/home',
                    builder: (context, state) => const SecondPageFirstScreen(),
                    routes: [
                      GoRoute(
                        path: '/second',
                        name: '/second',
                        builder: (context, state) => SecondPageSecondScreen(
                          from: state.uri.queryParameters['from'] ?? 'N/A',
                        ),
                        routes: [
                          GoRoute(
                            path: '/third',
                            name: '/third',
                            builder: (context, state) => SecondPageThirdScreen(
                              from: state.uri.queryParameters['from'] ?? 'N/A',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                builder: (
                  context,
                  state,
                  child,
                ) => HomePageLayout(scaffoldKey: _scaffoldKey, state: state, child: child)
              ),
              StatefulShellRoute.indexedStack(
                builder: (context, state, child) {
                  return SecondPageLayout(scaffoldKey: _scaffoldKey, child: child);
                },
                branches: [
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: '/a',
                        name: '/a',
                        routes: [
                          GoRoute(
                            path: '/next',
                            name: '/next',
                            builder: (context, state) => ColoredBox(
                              color: Theme.of(context).colorScheme.surface,
                              child: Center(
                                child: IntrinsicHeight(
                                  child: FilledButton(
                                    onPressed: () => context.pop(),
                                    child: const Text('Go Back!'),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                        builder: (context, state) => Center(
                          child: FilledButton(
                            onPressed: () => context.goNamed('/next'),
                            child: const Text('Go to Next!'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: '/b',
                        name: '/b',
                        builder: (context, state) => const Center(
                          child: Text('B'),
                        ),
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: '/c',
                        name: '/c',
                        builder: (context, state) => const Center(
                          child: Text('C'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: '/thirdPage',
                name: '/thirdPage',
                builder: (context, state) => ThirdPageLayout(scaffoldKey: _scaffoldKey),
              ),
            ],
            builder: (
              context,
              state,
              child,
            ) => MainLayout(scaffoldKey: _scaffoldKey, child: child),
          ),
        ],
      ),
    );
  }
}

