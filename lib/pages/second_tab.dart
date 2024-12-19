import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({
    super.key,
    required this.state,
    required this.child,
  });

  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: state.fullPath
                .toString()
                .substring(1)
                .split('/')
                .mapIndexed(
                  (i, p) => Row(
                    children: [
                      TextButton(
                        onPressed: p != state.fullPath?.split('/').last
                            ? () => context.goNamed('/$p')
                            : null,
                        child: Text(p),
                      ),
                      const Text('/'),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: Center(
            child: child,
          ),
        ),
      ],
    );
  }
}
