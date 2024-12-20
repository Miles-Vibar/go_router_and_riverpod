import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routing_app/providers/calculator_history_provider.dart';

class HistoryTab extends ConsumerWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = ref.watch(calculatorHistoryNotifierProvider);
    int lastIndex = Random().nextInt(Colors.primaries.length);
    return provider.isNotEmpty
        ? ListView.separated(
            itemCount: provider.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              int currentIndex = Random().nextInt(Colors.primaries.length);
              while (currentIndex == lastIndex) {
                currentIndex = Random().nextInt(Colors.primaries.length);
              }
              lastIndex = currentIndex;
              return ListTile(
                onTap: () => (),
                leading: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.primaries[lastIndex],
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        index.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  provider[index].equation,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                subtitle: Text(
                  provider[index].answer,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: Column(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          Icons.list_alt,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 3,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "There's no history\nyet...",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          );
  }
}
