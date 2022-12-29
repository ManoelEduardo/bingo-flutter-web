import 'dart:math';

import 'package:flutter/material.dart';

class Homecontroller {
  final List<int> numbers = [];
  ValueNotifier<List<int>> letterBNumbers = ValueNotifier([]);
  ValueNotifier<List<int>> letterINumbers = ValueNotifier([]);
  ValueNotifier<List<int>> letterNNumbers = ValueNotifier([]);
  ValueNotifier<List<int>> letterGNumbers = ValueNotifier([]);
  ValueNotifier<List<int>> letterONumbers = ValueNotifier([]);
  ValueNotifier<int> lastNumberDrawn = ValueNotifier(0);
  ValueNotifier<double> animatonSpeed = ValueNotifier(0);
  ValueNotifier<bool> isEnabledButton = ValueNotifier(false);
  String letter = "";

  numbersRaffle() {
    int drawnNumber = Random().nextInt(75) + 1;

    if (!numbers.contains(drawnNumber)) {
      numbers.add(drawnNumber);
    } else {
      numbersRaffle();
    }
  }

  lastDrawnNumberAndLetterAssignment() {
    lastNumberDrawn.value = numbers.toList().last;
    if (lastNumberDrawn.value <= 15) {
      letter = 'B';
      addingNumbersToEachLetter(letterBNumbers, lastNumberDrawn);
    } else if (lastNumberDrawn.value > 15 && lastNumberDrawn.value <= 30) {
      letter = 'I';
      addingNumbersToEachLetter(letterINumbers, lastNumberDrawn);
    } else if (lastNumberDrawn.value > 30 && lastNumberDrawn.value <= 45) {
      letter = 'N';
      addingNumbersToEachLetter(letterNNumbers, lastNumberDrawn);
    } else if (lastNumberDrawn.value > 45 && lastNumberDrawn.value <= 60) {
      letter = 'G';
      addingNumbersToEachLetter(letterGNumbers, lastNumberDrawn);
    } else {
      letter = 'O';
      addingNumbersToEachLetter(letterONumbers, lastNumberDrawn);
    }
  }

  addingNumbersToEachLetter(
      ValueNotifier<List<int>> numbersByLetters, ValueNotifier<int> number) {
    numbersByLetters.value = List.from(numbersByLetters.value)
      ..add(number.value);
  }

  startGameBallAnimation() async {
    numbersRaffle();
    isEnabledButton.value = true;
    animatonSpeed.value = 2;
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      if (isEnabledButton.value) lastDrawnNumberAndLetterAssignment();
      animatonSpeed.value = 0;
      isEnabledButton.value = false;
    });
  }

  clearingGameData() {
    isEnabledButton.value = false;
    numbers.clear();
    letter = "";
    lastNumberDrawn.value = 0;
    letterBNumbers.value = [];
    letterINumbers.value = [];
    letterNNumbers.value = [];
    letterGNumbers.value = [];
    letterONumbers.value = [];
  }
}
