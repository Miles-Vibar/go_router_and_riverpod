import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'keyboard_listener_provider.g.dart';

@Riverpod(keepAlive: true)
class KeyboardListenerNotifier extends _$KeyboardListenerNotifier {
  @override
  List<LogicalKeyboardKey> build() {
    return <LogicalKeyboardKey>[];
  }

  void add(LogicalKeyboardKey value) {
    state.add(value);
  }

  void deleteAll() {
    state = [];
  }

  void deleteOne(int index) {
    state.removeAt(index);
  }
}