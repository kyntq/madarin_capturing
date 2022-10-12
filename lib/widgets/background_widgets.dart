import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  var mIndex = -1;

  void initializeGame() {
    currentPlayer = PLAYER_1;
    endGame = false;
    score1 = 0;
    score2 = 0;

    listBoard = [
      Box(5, false, Colors.blue, false), //2
      Box(5, false, Colors.blue, false), //3
      Box(5, false, Colors.blue, false), //4
      Box(5, false, Colors.blue, false), //5
      Box(5, false, Colors.blue, false),
      Box(1, true, Colors.red, false),
      Box(5, false, Colors.blue, false), //7
      Box(5, false, Colors.blue, false), //9
      Box(5, false, Colors.blue, false), //10
      Box(5, false, Colors.blue, false), //11
      Box(5, false, Colors.blue, false),
      Box(1, true, Colors.red, false),
    ];
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    initializeGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    final double itemWidth = deviceSize.width / 2;
    return Column(
      children: [
        const SizedBox(height: 24),
        AbsorbPointer(
          absorbing: currentPlayer == PLAYER_1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: Text(
                  'Player 2',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: currentPlayer == PLAYER_2 ? Colors.lightBlue : Colors.black),
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {
                      if (mIndex < 0) return;
                      clickRight(mIndex);
                    }, icon: const Icon(Icons.arrow_right, size: 48,)),
                    Text('DẢI SANG TRÁI')
                  ],
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {
                      if (mIndex < 0) return;
                      clickLeft(mIndex);
                    }, icon: const Icon(Icons.arrow_left, size: 48)),
                    Text('DẢI SANG PHẢI')
                  ],
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: Text('Score: $score2', style: TextStyle(fontSize: 23,
                    color: currentPlayer == PLAYER_2 ? Colors.lightBlue : Colors.black,
                    fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        initializeGame();
                      });
                    },
                    icon: const Icon(Icons.restart_alt, size: 36)),
              ),
              const SizedBox(width: 24),
              AbsorbPointer(
                  child: SizedBox(width: 120, child: singleBox(11, listBoard[11].isMandari, isLeft: true)),
                  absorbing: true),
              Container(
                width: itemWidth,
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
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 1),
                        itemBuilder: (BuildContext context, int index) {
                          // print('============= ${listBoard[index].color.toString()}');
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
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 1),
                        itemBuilder: (BuildContext context, int index) {
                          // print('============= ${listBoard[index].color.toString()}');
                          return singleBox(index + 6, listBoard[index + 6].isMandari);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              AbsorbPointer(child: SizedBox(width: 120, child: singleBox(5, listBoard[5].isMandari)), absorbing: true),
              const SizedBox(width: 24),
              IconButton(
                  onPressed: () {
                    setState(() {
                      initializeGame();
                    });
                  },
                  icon: const Icon(Icons.restart_alt, size: 36)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AbsorbPointer(
          absorbing: currentPlayer == PLAYER_2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Player 1',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: currentPlayer == PLAYER_1 ? Colors.lightBlue : Colors.black)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    if (mIndex < 0) return;
                    clickLeft(mIndex);
                  }, icon: const Icon(Icons.arrow_left, size: 48,)),
                  Text('DẢI SANG TRÁI')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    if (mIndex < 0) return;
                    clickRight(mIndex);
                  }, icon: const Icon(Icons.arrow_right, size: 48)),

                  Text('DẢI SANG PHẢI')
                ],
              ),

              Text('Score: $score1', style: TextStyle(
                  fontSize: 23,
                  color: currentPlayer == PLAYER_1 ? Colors.lightBlue : Colors.black,
                  fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 16),
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

    Timer.periodic(const Duration(milliseconds: 750), (timer) {
      try {
        // listBoard[i].color = Colors.orange;
        setState(() {
          var iYellow = i+1>11?0:i+1;
          var iBlue = i>11?0:i;
          listBoard[iYellow].color = Colors.yellow;
          listBoard[iBlue].color = listBoard[iBlue].isMandari ? Colors.red : Colors.blue;
        });
        print('${timer.tick}');
        if (boc > 0) {
          boc--;
          i++;
          if (i == 12) i = 0;
          listBoard[i].score++;
          if (boc == 0) {
            if (!listBoard[i + 1 == 12 ? 0 : i + 1].isMandari && listBoard[i + 1 == 12 ? 0 : i + 1].score != 0) {
              i++;
              listBoard[i-1>11?0:i-1].color = listBoard[i-1>11?0:i-1].isMandari ? Colors.red : Colors.blue;
              if (i == 12) i = 0;
              boc = listBoard[i].score;
              listBoard[i].score = 0;
            } else {
              listBoard[i].color = listBoard[i].isMandari ? Colors.red : Colors.blue;
              stop = true;
              print('stop 2');
            }
          } else {
            print('stop 2');
          }
        }

        if (stop) {
          changeTurn();
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

    Timer.periodic(const Duration(milliseconds: 750), (timer) {
      try {
        setState(() {
          var iYellow = i-1<0?11:i-1;
          var iBlue = i<0?11:i;
          listBoard[iYellow].color = Colors.yellow;
          listBoard[iBlue].color = listBoard[iBlue].isMandari ? Colors.red : Colors.blue;
        });
        if (boc > 0) {
          boc--;
          i--;
          if (i == -1) i = 11;
          listBoard[i].score++;
          if (boc == 0) {
            if (!listBoard[i - 1 == -1 ? 11 : i - 1].isMandari && listBoard[i - 1 == -1 ? 11 : i - 1].score != 0) {
              i--;
              listBoard[i+1<0?11:i+1].color = listBoard[i+1<0?11:i+1].isMandari ? Colors.red : Colors.blue;
              if (i == -1) i = 11;
              boc = listBoard[i].score;
              listBoard[i].score = 0;
            } else {
              listBoard[i].color = listBoard[i].isMandari ? Colors.red : Colors.blue;
              stop = true;
            }
          }
        }
        if (stop) {
          changeTurn();
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
    for (int i = 0; i< listBoard.length; i++) {
      listBoard[i].selected = false;
    }
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
        setState(() {
          mIndex = index;
          for (int i = 0; i< listBoard.length; i++) {
            listBoard[i].selected = false;
          }
          listBoard[mIndex].selected = true;
        });
        /*showDialog(
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
                        Navigator.of(context).pop();
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
                ));*/
      },
      child: Container(
        decoration: BoxDecoration(
            color: listBoard[index].score == 0
                ? Colors.grey
                : listBoard[index].selected ? Colors.lightBlue : listBoard[index].color,
            borderRadius: isMandari ? radius : BorderRadius.zero,
            border: Border.all(width: .5, color: Colors.black)),
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: Text(
                    '${listBoard[index].score}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: currentPlayer == PLAYER_2 ? 38 : 12
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '${listBoard[index].score}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: currentPlayer == PLAYER_1 ? 38 : 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }

  void clickLeft(int index) {
    setState(() {
      checkScattered();
      directLeft_cf(index);
      checkForWin();
    });
  }

  void clickRight(int index) {
    setState(() {
      checkScattered();
      directRight_cf(index);
      checkForWin();
    });
  }

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
