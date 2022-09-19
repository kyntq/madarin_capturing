import 'package:flutter/material.dart';

import 'box.dart';

class Board with ChangeNotifier {
  List<Box> listBoard = [
    Box(5, false),
    Box(5, false),
    Box(5, false),
    Box(5, false),
    Box(5, false),
    Box(1, true),
    Box(5, false),
    Box(5, false),
    Box(5, false),
    Box(5, false),
    Box(5, false),
    Box(1, true),
  ];

  List<Box> get list {
    return [...listBoard];
  }

  void updateList(int index, Box value) {
    listBoard.removeAt(index);
    listBoard.insert(index, value);
    notifyListeners();
  }

  // int directRight(int index) {
  //   int score = 0;
  //   int boc = listBoard[index].score;
  //   int i = index + 1;
  //   listBoard[index].score = 0;
  //   listBoard[i].score++;
  //   while (true) {
  //     boc--;
  //     i++;
  //     if (i == 12) i = 0;
  //     listBoard[i].score++;
  //
  //     if (boc == 0 && listBoard[(i + 1) == 12 ? 0 : i + 1].isMandari) break;
  //     if (boc == 0 && listBoard[(i + 1) == 12 ? 0 : i + 1].isMandari) break;
  //     if (boc == 0 && listBoard[(i + 1) == 12 ? 0 : i + 1] == 0) {
  //       while (((i + 1) == 12 ? 0 : i + 1) == 0 &&
  //           listBoard[(i + 2) == 12 ? 0 : i + 2].score != 0) {
  //         i += 2;
  //         if (i == 12) i = 0;
  //         if (listBoard[i].isMandari) score += 10;
  //         score += listBoard[i].score;
  //         listBoard[i].score = 0;
  //       }
  //       break;
  //     }
  //     if (boc == 0 &&
  //         listBoard[(i + 1) == 12 ? 0 : i + 1] != 0 &&
  //         !listBoard[(i + 1) == 12 ? 0 : i + 1].isMandari) {
  //       boc = listBoard[(i + 1) == 12 ? 0 : i + 1].score;
  //       listBoard[(i + 1) == 12 ? 0 : i + 1].score = 0;
  //       i = (i + 1) == 12 ? 0 : i + 1;
  //     }
  //   }
  //
  //   notifyListeners();
  //   return score;
  // }
  int directRight(int index) {
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;
    while (boc > 0) {
      boc--;
      i++;
      if (i == 12) i = 0;
      listBoard[i].score++;
      if (boc == 0) {
        if (!listBoard[i - 1 == -1 ? 11 : i - 1].isMandari &&
            listBoard[i - 1 == -1 ? 11 : i - 1].score != 0) {
          i++;
          if (i == 12) i = 0;
          boc = listBoard[i].score;
          listBoard[i].score = 0;
        }
      }
    }
    while (listBoard[i - 1 == -1 ? 11 : i - 1].score == 0 &&
        listBoard[i + 2 == 12 ? 0 : i + 2].score != 0 &&
        !listBoard[i - 1 == -1 ? 11 : i - 1].isMandari) {
      i = i + 1 == 12 ? 0 : i + 1;
      i = i + 1 == 12 ? 0 : i + 1;
      if (listBoard[i].isMandari) score += 9;
      score += listBoard[i].score;
      listBoard[i].score = 0;
    }
    notifyListeners();
    return score;
  }

  int directLeft(int index) {
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;
    while (boc > 0) {
      boc--;
      i--;
      if (i == -1) i = 11;
      listBoard[i].score++;
      if (boc == 0) {
        if (!listBoard[i - 1 == -1 ? 11 : i - 1].isMandari &&
            listBoard[i - 1 == -1 ? 11 : i - 1].score != 0) {
          i--;
          if (i == -1) i = 11;
          boc = listBoard[i].score;
          listBoard[i].score = 0;
        }
      }
    }
    while (listBoard[i - 1 == -1 ? 11 : i - 1].score == 0 &&
        listBoard[i - 2 == -1 ? 11 : i - 2].score != 0 &&
        !listBoard[i - 1 == -1 ? 11 : i - 1].isMandari) {
      i = i - 1 == -1 ? 11 : i - 1;
      i = i - 1 == -1 ? 11 : i - 1;
      if (listBoard[i].isMandari) score += 9;
      score += listBoard[i].score;
      listBoard[i].score = 0;
    }
    notifyListeners();
    return score;
  }
}
