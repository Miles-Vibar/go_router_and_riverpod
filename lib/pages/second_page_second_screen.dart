import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class SecondPageSecondScreen extends StatelessWidget {
  const SecondPageSecondScreen({super.key, required this.from});

  final String from;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
            (duration) => ScaffoldMessenger.of(context).removeCurrentSnackBar());

    // TODO: implement build
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
                onPressed: () async {
                  final String? result = await context.push(Uri(
                    path: '/home/second/third',
                    queryParameters: {'from': 'Opened from Second Screen'},
                  ).toString());

                  if (!context.mounted) return;

                  if (result != null) {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(result)));
                  }
                },
                child: const Text('Go to Third Page'),
              ),
              const SizedBox(
                height: 24,
              ),
              FilledButton(
                onPressed: () => context.pop('Returned from second page!'),
                child: const Text('Go to Home Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}