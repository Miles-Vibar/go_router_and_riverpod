import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routing_app/providers/calculator_history_provider.dart';
import 'package:routing_app/providers/calculator_provider.dart';
import 'package:routing_app/providers/keyboard_listener_provider.dart';

enum Operator {
  add,
  subtract,
  multiply,
  divide,
}

class CalculatorTab extends ConsumerStatefulWidget {
  const CalculatorTab({
    super.key,
  });

  @override
  ConsumerState<CalculatorTab> createState() => _CalculatorTabState();
}

class _CalculatorTabState extends ConsumerState<CalculatorTab> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = '0';
  }

  ButtonStyle operatorStyle() {
    return FilledButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }

  ButtonStyle numberStyle() {
    return FilledButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      shape: CircleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(calculatorNotifierProvider);
    
    if (controller.text == '0' && provider.firstNumber != '') {
      ref.read(calculatorNotifierProvider.notifier).setNumbers(controller, '');
    }
    
    return KeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is! KeyDownEvent) {
          return;
        }

        if (event.logicalKey == LogicalKeyboardKey.backspace) {
          ref.read(calculatorNotifierProvider.notifier).backspace(controller);
          ref.read(keyboardListenerNotifierProvider.notifier).add(LogicalKeyboardKey.backspace);
        } else if (event.logicalKey == LogicalKeyboardKey.numpadAdd ||
            (HardwareKeyboard.instance.isShiftPressed &&
                event.logicalKey == LogicalKeyboardKey.equal)) {
          ref
              .read(calculatorNotifierProvider.notifier)
              .setOperator(controller, Operator.add);
          ref.read(keyboardListenerNotifierProvider.notifier).add(LogicalKeyboardKey.numpadAdd);
        } else if (event.logicalKey == LogicalKeyboardKey.numpadSubtract ||
            event.logicalKey == LogicalKeyboardKey.minus) {
          ref
              .read(calculatorNotifierProvider.notifier)
              .setOperator(controller, Operator.subtract);
          ref.read(keyboardListenerNotifierProvider.notifier).add(LogicalKeyboardKey.numpadSubtract);
        } else if (event.logicalKey == LogicalKeyboardKey.numpadMultiply ||
            (HardwareKeyboard.instance.isShiftPressed &&
                event.logicalKey == LogicalKeyboardKey.digit8)) {
          ref
              .read(calculatorNotifierProvider.notifier)
              .setOperator(controller, Operator.multiply);
          ref.read(keyboardListenerNotifierProvider.notifier).add(LogicalKeyboardKey.numpadMultiply);
        } else if (event.logicalKey == LogicalKeyboardKey.numpadDivide ||
            event.logicalKey == LogicalKeyboardKey.slash) {
          ref
              .read(calculatorNotifierProvider.notifier)
              .setOperator(controller, Operator.divide);
          ref.read(keyboardListenerNotifierProvider.notifier).add(LogicalKeyboardKey.numpadDivide);
        } else if (event.logicalKey == LogicalKeyboardKey.numpadEqual ||
            event.logicalKey == LogicalKeyboardKey.equal) {
          ref.read(calculatorNotifierProvider.notifier).equals(controller);
          ref.read(keyboardListenerNotifierProvider.notifier).add(LogicalKeyboardKey.numpadEqual);
        } else if (int.tryParse(event.logicalKey.keyLabel) != null) {
          ref
              .read(calculatorNotifierProvider.notifier)
              .setNumbers(controller, event.logicalKey.keyLabel);
        }
        ref.read(keyboardListenerNotifierProvider.notifier).add(event.logicalKey);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 48.0,
                  right: 8.0,
                ),
                child: Text(
                  provider.equation ?? '',
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            ],
          ),
          TextField(
            enabled: false,
            controller: controller,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 40,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: 48,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              children: [
                TableRow(
                  children: [
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .clearAll(controller),
                      child: const Text('CA'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .toggleSign(controller),
                      child: const Text('+/-'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .backspace(controller),
                      child: const Icon(Icons.backspace),
                    ),
                    CustomTableCell(
                      style: operatorStyle(),
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setOperator(controller, Operator.divide),
                      child: const Text(('/')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '7'),
                      style: numberStyle(),
                      child: const Text('7'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '8'),
                      style: numberStyle(),
                      child: const Text('8'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '9'),
                      style: numberStyle(),
                      child: const Text('9'),
                    ),
                    CustomTableCell(
                      style: operatorStyle(),
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setOperator(controller, Operator.multiply),
                      child: const Text(('*')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '4'),
                      style: numberStyle(),
                      child: const Text('4'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '5'),
                      style: numberStyle(),
                      child: const Text('5'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '6'),
                      style: numberStyle(),
                      child: const Text('6'),
                    ),
                    CustomTableCell(
                      style: operatorStyle(),
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setOperator(controller, Operator.subtract),
                      child: const Text(('-')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '1'),
                      style: numberStyle(),
                      child: const Text('1'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '2'),
                      style: numberStyle(),
                      child: const Text('2'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '3'),
                      style: numberStyle(),
                      child: const Text('3'),
                    ),
                    CustomTableCell(
                      style: operatorStyle(),
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setOperator(controller, Operator.add),
                      child: const Text(('+')),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    CustomTableCell(
                      style: FilledButton.styleFrom(elevation: 0),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '0'),
                      style: numberStyle(),
                      child: const Text('0'),
                    ),
                    CustomTableCell(
                      onPressed: () => ref
                          .read(calculatorNotifierProvider.notifier)
                          .setNumbers(controller, '.'),
                      style: numberStyle(),
                      child: const Text('.'),
                    ),
                    CustomTableCell(
                      style: operatorStyle(),
                      onPressed: () {
                        if (provider.operator == null) return;
                        ref
                            .read(calculatorHistoryNotifierProvider.notifier)
                            .addEquation(
                                '${ref.read(calculatorNotifierProvider.notifier).equals(controller)} = ',
                                controller.text);
                      },
                      child: const Text(('=')),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    super.key,
    this.child,
    this.onPressed,
    this.style,
  });

  final Widget? child;
  final void Function()? onPressed;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: FilledButton(
            onPressed: onPressed,
            style: style,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
