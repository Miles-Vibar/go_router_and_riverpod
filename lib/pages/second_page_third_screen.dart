import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class SecondPageThirdScreen extends StatelessWidget {
  const SecondPageThirdScreen({super.key, required this.from});

  final String from;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
            (duration) => ScaffoldMessenger.of(context).removeCurrentSnackBar());

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Text(from),
              const SizedBox(
                height: 24,
              ),
              FilledButton(
                onPressed: () => context.pop('Returned from third page!'),
                child: const Text('Go to Second Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}