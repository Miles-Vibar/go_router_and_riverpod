import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pages/calculator_tab.dart';

part 'calculator_provider.g.dart';

class CalculatorState extends Equatable {
  String firstNumber;
  bool isFirstNumberPositive;
  String secondNumber;
  bool isSecondNumberPositive;
  Operator? operator;
  bool isAnswer;
  String? equation;

  CalculatorState({
    required this.firstNumber,
    required this.isFirstNumberPositive,
    required this.secondNumber,
    required this.isSecondNumberPositive,
    this.operator,
    required this.isAnswer,
    this.equation,
  });

  CalculatorState copyWith({
    String? firstNumber,
    bool? isFirstNumberPositive,
    String? secondNumber,
    bool? isSecondNumberPositive,
    Operator? operator,
    bool? isAnswer,
    String? equation,
  }) {
    return CalculatorState(
      firstNumber: firstNumber ?? this.firstNumber,
      operator: operator ?? this.operator,
      isFirstNumberPositive: isFirstNumberPositive ?? this.isFirstNumberPositive,
      secondNumber: secondNumber ?? this.secondNumber,
      isSecondNumberPositive: isSecondNumberPositive ?? this.isSecondNumberPositive,
      isAnswer: isAnswer ?? this.isAnswer,
      equation: equation ?? this.equation,
    );
  }

  @override
  List<Object?> get props => [
    equation,
  ];
}

@Riverpod(keepAlive: true)
class CalculatorNotifier extends _$CalculatorNotifier {
  @override
  CalculatorState build() {
    return CalculatorState(
      firstNumber: '',
      isFirstNumberPositive: true,
      secondNumber: '',
      isSecondNumberPositive: true,
      isAnswer: true,
      equation: null,
    );
  }

  void setNumbers(
    TextEditingController controller,
    String number,
  ) {
    if (controller.text[controller.text.length - 1] == '.' && number == '.') {
      return;
    }

    if (((controller.text == '0' || controller.text == '-0') &&
            number != '.' &&
            number != '') ||
        (state.isAnswer && number != '')) {
      controller.clear();
      state.isAnswer = false;
    }

    if (state.operator == null) {
      if (state.firstNumber != '0') {
        state.firstNumber += number;
      } else {
        state.firstNumber = number;
      }
    } else {
      if (state.secondNumber != '0') {
        state.secondNumber += number;
      } else {
        state.secondNumber = number;
      }
    }

    setOperator(controller, state.operator);
  }

  void toggleSign(TextEditingController controller) {
    if (state.operator == null) {
      state.isFirstNumberPositive = !state.isFirstNumberPositive;
    } else {
      state.isSecondNumberPositive = !state.isSecondNumberPositive;
    }

    setNumbers(controller, '');
  }

  void setOperator(
    TextEditingController controller,
    Operator? operator,
  ) {
    state.operator = operator;

    if (state.firstNumber.isEmpty) {
      state.firstNumber = controller.text;
    }

    controller.text =
        (state.isFirstNumberPositive ? '' : '-') + state.firstNumber;

    switch (operator) {
      case Operator.add:
        controller.text += ' + ';
        break;
      case Operator.subtract:
        controller.text += ' - ';
        break;
      case Operator.multiply:
        controller.text += ' * ';
        break;
      case Operator.divide:
        controller.text += ' / ';
        break;
      case null:
        break;
    }

    controller.text += (state.isSecondNumberPositive
        ? state.secondNumber
        : ' (-${state.secondNumber == '' ? '0' : state.secondNumber})');
  }

  String equals(TextEditingController controller) {
    if (state.operator == null && state.secondNumber == '') return '';

    if (state.secondNumber.isEmpty) {
      setNumbers(controller, '0');
    }

    try {
      state = state.copyWith(equation: controller.text);
      switch (state.operator) {
        case Operator.add:
          controller.text = (((state.isFirstNumberPositive ? 1 : -1) *
              (double.tryParse(state.firstNumber) ?? 0)) +
              ((state.isSecondNumberPositive ? 1 : -1) *
                  (double.tryParse(state.secondNumber) ?? 0)))
              .toString();
        case Operator.subtract:
          controller.text = (((state.isFirstNumberPositive ? 1 : -1) *
              (double.tryParse(state.firstNumber) ?? 0)) -
              ((state.isSecondNumberPositive ? 1 : -1) *
                  (double.tryParse(state.secondNumber) ?? 0)))
              .toString();
        case Operator.multiply:
          controller.text = (((state.isFirstNumberPositive ? 1 : -1) *
              (double.tryParse(state.firstNumber) ?? 0)) *
              ((state.isSecondNumberPositive ? 1 : -1) *
                  (double.tryParse(state.secondNumber) ?? 0)))
              .toString();
        case Operator.divide:
          controller.text = (((state.isFirstNumberPositive ? 1 : -1) *
              (double.tryParse(state.firstNumber) ?? 0)) /
              ((state.isSecondNumberPositive ? 1 : -1) *
                  (double.tryParse(state.secondNumber) ?? 0)))
              .toString();
        default:
          controller.text = 'undefined';
      }
    } catch (e) {
      controller.text = 'undefined';
    } finally {
      state.isAnswer = true;
      state.firstNumber = '';
      state.secondNumber = '';
      state.isSecondNumberPositive = true;
      state.isFirstNumberPositive = true;
      state.operator = null;
    }
    return state.equation!;
  }

  void clearAll(TextEditingController controller) {
    controller.text = '0';
    state.firstNumber = '';
    state.secondNumber = '';
    state.isSecondNumberPositive = true;
    state.isFirstNumberPositive = true;
    state.operator = null;
    state.isAnswer = true;
    state.equation = null;
  }

  void backspace(TextEditingController controller) {
    if (state.secondNumber.isNotEmpty) {
      state.secondNumber = state.secondNumber.substring(0, state.secondNumber.length - 1);
    } else if (controller.text.endsWith(' ')) {
      controller.text =
          controller.text.substring(0, controller.text.length - 3);
      state.operator = null;
    } else if (state.firstNumber.isNotEmpty) {
      state.secondNumber = '';
      if (state.firstNumber.length == 1) {
        state.firstNumber = '';
        controller.text = '0';
      } else {
        state.firstNumber = state.firstNumber.substring(0, state.firstNumber.length - 1);
      }
    } else {
      state.firstNumber = '';
      controller.text = '0';
    }

    setNumbers(controller, '');
  }
}

@riverpod
String secondNumber(ref) {
  return '';
}

@riverpod
bool isFirstNumberPositive(ref) {
  return true;
}

@riverpod
bool isSecondNumberPositive(ref) {
  return true;
}

@riverpod
Operator? operator(ref) {
  return null;
}

@riverpod
bool isAnswer(ref) {
  return true;
}
