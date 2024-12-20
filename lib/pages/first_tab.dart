import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routing_app/providers/keyboard_listener_provider.dart';

class FirstTab extends ConsumerWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = ref.watch(keyboardListenerNotifierProvider);
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Dismissible(
          key: ValueKey<int>(index),
          onDismissed: (direction) => ref.read(keyboardListenerNotifierProvider.notifier).deleteOne(index),
          background: ColoredBox(color: Theme.of(context).colorScheme.error),
          child: ListTile(
            leading: Text(provider[index].keyId.toString().padLeft(10, '0')),
            title: Text('Pressed the key: ${provider[index].keyLabel}'),
            trailing: Text(provider[index].debugName.toString()),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: provider.length,
    );
  }
}
