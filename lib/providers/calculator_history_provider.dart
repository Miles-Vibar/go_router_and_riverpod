import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calculator_history_provider.g.dart';

class HistoryEntry extends Equatable {
  final String equation;
  final String answer;

  const HistoryEntry({
    required this.equation,
    required this.answer,
  });

  @override
  List<Object?> get props => [
        equation,
        answer,
      ];
}

@Riverpod(keepAlive: true)
class CalculatorHistoryNotifier extends _$CalculatorHistoryNotifier {
  @override
  List<HistoryEntry> build() {
    return <HistoryEntry>[];
  }

  void addEquation(String equation, String answer) {
    state.add(HistoryEntry(equation: equation, answer: answer));
  }

  void deleteHistory() {
    state = [];
  }
}
