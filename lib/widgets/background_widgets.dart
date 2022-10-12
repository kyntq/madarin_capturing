import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/box.dart';

class Background extends StatefulWidget {
  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  static const String PLAYER_1 = "Người chơi 1";
  static const String PLAYER_2 = "Người chơi 2";
  int score1 = 0;
  int score2 = 0;
  late bool endGame;
  late String currentPlayer;
  late List<Box> listBoard;

  void initializeGame() {
    currentPlayer = PLAYER_1;
    endGame = false;
    score1 = 0;
    score2 = 0;

    listBoard = [
      Box(5, false, Colors.blue), //2
      Box(5, false, Colors.blue), //3
      Box(5, false, Colors.blue), //4
      Box(5, false, Colors.blue), //5
      Box(5, false, Colors.blue),
      Box(1, true, Colors.red),
      Box(5, false, Colors.blue), //7
      Box(5, false, Colors.blue), //9
      Box(5, false, Colors.blue), //10
      Box(5, false, Colors.blue), //11
      Box(5, false, Colors.blue),
      Box(1, true, Colors.red),
    ];
  }

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('================= build');
    Size deviceSize = MediaQuery.of(context).size;
    final double itemWidth = deviceSize.width / 2;
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Player 2',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: currentPlayer == PLAYER_2 ? Colors.red : Colors.black),
            ),
            Text('Score: $score2', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AbsorbPointer(
                  child: SizedBox(width: 120, child: singleBox(11, listBoard[11].isMandari, isLeft: true)),
                  absorbing: true),
              Container(
                width: itemWidth,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AbsorbPointer(
                      absorbing: currentPlayer == PLAYER_1,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: .889),
                        itemBuilder: (BuildContext context, int index) {
                          print('============= ${listBoard[index].color.toString()}');
                          return singleBox(index, listBoard[index].isMandari);
                        },
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: currentPlayer == PLAYER_2,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        reverse: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: .889),
                        itemBuilder: (BuildContext context, int index) {
                          print('============= ${listBoard[index].color.toString()}');
                          return singleBox(index + 6, listBoard[index + 6].isMandari);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AbsorbPointer(child: SizedBox(width: 120, child: singleBox(5, listBoard[5].isMandari)), absorbing: true),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Player 1',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: currentPlayer == PLAYER_1 ? Colors.red : Colors.black)),
            Text('Score: $score1', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: () {
                  setState(() {
                    initializeGame();
                  });
                },
                icon: const Icon(Icons.restart_alt))
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  var stop = false;

  // Game process
  void directLeft_cf(int index) {
    stop = false;
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      try {
        // listBoard[i].color = Colors.orange;
        setState(() {});
        print('${timer.tick}');
        if (boc > 0) {
          boc--;
          i++;
          if (i == 12) i = 0;
          listBoard[i].score++;
          if (boc == 0) {
            if (!listBoard[i + 1 == 12 ? 0 : i + 1].isMandari && listBoard[i + 1 == 12 ? 0 : i + 1].score != 0) {
              i++;
              if (i == 12) i = 0;
              boc = listBoard[i].score;
              listBoard[i].score = 0;
            } else {
              stop = true;
              print('stop 2');
            }
          } else {
            print('stop 2');
          }
        }

        if (stop) {
          timer.cancel();
          while (listBoard[i + 1 == 12 ? 0 : i + 1].score == 0 &&
              listBoard[i + 2 == 12 ? 0 : i + 2].score != 0 &&
              !listBoard[i + 1 == 12 ? 0 : i + 1].isMandari) {
            i = i + 1 == 12 ? 0 : i + 1;
            i = i + 1 == 12 ? 0 : i + 1;
            if (listBoard[i].isMandari) score += 9;
            score += listBoard[i].score;
            listBoard[i].score = 0;
          }
          if (currentPlayer == PLAYER_1) {
            score1 = score;
          } else {
            score2 = score;
          }
        }
      } catch (e) {
        timer.cancel();
      }
    });
  }

  void directRight_cf(int index) {
    stop = false;
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      try {
        setState(() {});
        if (boc > 0) {
          boc--;
          i--;
          if (i == -1) i = 11;
          listBoard[i].score++;
          if (boc == 0) {
            if (!listBoard[i - 1 == -1 ? 11 : i - 1].isMandari && listBoard[i - 1 == -1 ? 11 : i - 1].score != 0) {
              i--;
              if (i == -1) i = 11;
              boc = listBoard[i].score;
              listBoard[i].score = 0;
            } else {
              stop = true;
            }
          }
        }
        if (stop) {
          timer.cancel();
          if (listBoard[i - 1 == -1 ? 11 : i - 1].score == 0 &&
              listBoard[i - 2 == -1 ? 11 : i - 2].score != 0 &&
              !listBoard[i - 1 == -1 ? 11 : i - 1].isMandari) {
            i = i - 1 == -1 ? 11 : i - 1;
            i = i - 1 == -1 ? 11 : i - 1;
            if (listBoard[i].isMandari) score += 9;
            score += listBoard[i].score;
            listBoard[i].score = 0;
          }

          if (currentPlayer == PLAYER_1) {
            score1 = score;
          } else {
            score2 = score;
          }
        }
      } catch (e) {
        timer.cancel();
      }
    });
  }

  void changeTurn() {
    if (currentPlayer == PLAYER_1) {
      currentPlayer = PLAYER_2;
    } else {
      currentPlayer = PLAYER_1;
    }
  }

  checkForWin() {
    String msg = '';
    var temp = listBoard.firstWhere((element) => element.isMandari);
    var temp2 = listBoard.lastWhere((element) => element.isMandari);
    if (temp.score == 0 && temp2.score == 0) {
      endGame = true;
      if (score1 > score2) {
        msg = 'Người chơi 1 chiến thắng với số điểm $score1'
            '\nNgười chơi 2 thua cuộc với số điểm $score2';
      }
      showGameOverMessage(msg);
      return;
    }
  }

  showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Game Over \n $message",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          )),
    );
  }

  Widget singleBox(index, bool isMandari, {bool? isLeft}) {
    if (index > 5 && index < 11) {
      index = 11 - index + 5;
    }
    // if (currentPlayer == PLAYER_1) {
    var radius = isLeft == true
        ? const BorderRadius.only(bottomLeft: Radius.circular(36), topLeft: Radius.circular(36))
        : const BorderRadius.only(bottomRight: Radius.circular(36), topRight: Radius.circular(36));
    return InkWell(
      onTap: () {
        if (endGame || listBoard[index].score == 0) return;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Chose your direct?'),
                  actions: <Widget>[
                    FlatButton(
                      child: const Text('Left'),
                      onPressed: () {
                        setState(() {
                          changeTurn();
                          checkScattered();
                          directLeft_cf(index);
                          checkForWin();
                        });
                      },
                    ),
                    FlatButton(
                      child: const Text('Right'),
                      onPressed: () {
                        setState(() {
                          changeTurn();
                          checkScattered();
                          directRight_cf(index);
                          checkForWin();
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: listBoard[index].color,
            borderRadius: isMandari ? radius : BorderRadius.zero,
            border: Border.all(width: .5, color: Colors.black)),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              '${listBoard[index].score}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMandari ? 38 : 32,
              ),
            )),
      ),
    );
    /*} else {
      return InkWell(
        onTap: listBoard[index].score == 0 || (index < 11 && index > 5)
            ? null
            : () {
                if (endGame) return;
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Chose your direct?'),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Left'),
                              onPressed: () {
                                setState(() {
                                  changeTurn();
                                  checkScattered();
                                  directRight_cf(index);

                                  checkForWin();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: const Text('Right'),
                              onPressed: () {
                                if (endGame) return;
                                setState(() {
                                  changeTurn();
                                  checkScattered();

                                  directLeft_cf(index);
                                  checkForWin();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              },
        child: Container(
          decoration: BoxDecoration(
              color:
                  listBoard[index].score == 0 ? Colors.grey : (listBoard[index].isMandari ? Colors.red : Colors.blue),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 5, color: Colors.black)),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                // '$index',
                '${listBoard[index].score}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              )),
        ),
      );
    }*/
  }

  void checkTurn() {}

  void checkScattered() {
    int temp1 = 0;
    int temp2 = 0;
    for (int i = 0; i <= 4; i++) {
      temp1 += listBoard[i].score;
    }
    for (int i = 5; i < 10; i++) {
      temp2 += listBoard[i].score;
    }

    if ((temp1 == 0) && (listBoard[0].score != 0 || listBoard[11].score != 0)) {
      // rai cho team 1
      scattered('1');
    }
    if ((temp1 == 0) && (listBoard[0].score != 0 || listBoard[11].score != 0)) {
      // rai cho team 2
      scattered('2');
    }
  }

  void scattered(String team) {
    if (team.compareTo('1') == 0) {
      //rai cho team 1
      score1 -= 5;
      if (score1 < 0) {
        endGame = true;
        return;
      }
      for (int i = 0; i < 5; i++) {
        listBoard[i].score++;
      }
    }
    if (team.compareTo('2') == 0) {
      //rai cho team 2
      score2 -= 5;
      if (score1 < 0) {
        endGame = true;
        return;
      }
      for (int i = 6; i < 11; i++) {
        listBoard[i].score++;
      }
    }
  }
}
