import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondPageFirstScreen extends StatelessWidget {
  const SecondPageFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: FilledButton(
          onPressed: () async {
            final String? result = await context.push(Uri(
              path: '/home/second',
              queryParameters: {'from': 'Opened from Second tab'},
            ).toString());

            if (!context.mounted) return;

            if (result != null) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(result)));
            }
          },
          child: const Text('Go to Second Page'),
        ),
      ),
    );
  }
}