import 'dart:math';

import 'package:flutter/material.dart';

class Homecontroller extends ChangeNotifier {
  List<int> drawnNumbers = [];
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
    int drawnNumber = Random().nextInt(90) + 1;

    if (!drawnNumbers.contains(drawnNumber)) {
      drawnNumbers.add(drawnNumber);
    } else {
      numbersRaffle();
    }
  }

  lastDrawnNumberAndLetterAssignment() {
    lastNumberDrawn.value = drawnNumbers.toList().last;
    if (lastNumberDrawn.value <= 18) {
      letter = 'B';
      addingNumbersToEachLetter(letterBNumbers, lastNumberDrawn);
    } else if (lastNumberDrawn.value > 18 && lastNumberDrawn.value <= 36) {
      letter = 'I';
      addingNumbersToEachLetter(letterINumbers, lastNumberDrawn);
    } else if (lastNumberDrawn.value > 36 && lastNumberDrawn.value <= 54) {
      letter = 'N';
      addingNumbersToEachLetter(letterNNumbers, lastNumberDrawn);
    } else if (lastNumberDrawn.value > 54 && lastNumberDrawn.value <= 72) {
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
    drawnNumbers.clear();
    letter = "";
    lastNumberDrawn.value = 0;
    letterBNumbers.value = [];
    letterINumbers.value = [];
    letterNNumbers.value = [];
    letterGNumbers.value = [];
    letterONumbers.value = [];
  }
}
