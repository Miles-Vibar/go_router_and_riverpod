import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routing_app/pages/calculator_tab.dart';
import 'package:routing_app/pages/history_tab.dart';
import 'package:routing_app/providers/calculator_history_provider.dart';

class ThirdPageLayout extends ConsumerStatefulWidget {
  const ThirdPageLayout({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ConsumerState<ThirdPageLayout> createState() => _ThirdPageLayoutState();
}

class _ThirdPageLayoutState extends ConsumerState<ThirdPageLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod'),
          leading: DrawerButton(
            onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Text('Calculator')),
              Tab(icon: Text('History')),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Deletion of History'),
                      content: const Text('Delete all entries in history? This action is irreversible.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('CANCEL'),
                        ),
                        FilledButton(
                          onPressed: () {
                            ref
                                .read(
                                    calculatorHistoryNotifierProvider.notifier)
                                .deleteHistory();
                            Navigator.pop(context);
                          },
                          child: const Text('DELETE ALL'),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete_forever),
            )
          ],
        ),
        body: const TabBarView(
          children: [
            CalculatorTab(),
            HistoryTab(),
          ],
        ),
      ),
    );
  }
}
