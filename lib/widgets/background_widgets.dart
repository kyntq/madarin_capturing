import 'dart:async';

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
      Box(5, false, Colors.blue, false), //0
      Box(5, false, Colors.blue, false), //1
      Box(5, false, Colors.blue, false), //2
      Box(5, false, Colors.blue, false), //3
      Box(5, false, Colors.blue, false), //4
      Box(10, true, Colors.red, false), //5
      Box(5, false, Colors.blue, false), //6
      Box(5, false, Colors.blue, false), //7
      Box(5, false, Colors.blue, false), //8
      Box(5, false, Colors.blue, false), //9
      Box(5, false, Colors.blue, false), //10
      Box(10, true, Colors.red, false), //11
    ];
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    initializeGame();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  // double itemWidth = 1 ;
  // Size deviceSize = const Size(1, 1);
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double itemWidth = deviceSize.width / 2.1;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              AbsorbPointer(
                absorbing: currentPlayer == PLAYER_1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: Text(
                        'Player 2',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: currentPlayer == PLAYER_2
                                ? Colors.lightBlue
                                : Colors.black),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (mIndex < 0) return;
                                clickRight(mIndex);
                              },
                              iconSize: 48,
                              icon: const Icon(Icons.arrow_right, size: 48)),
                          const Text('DẢI SANG PHẢI')
                        ],
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (mIndex < 0) return;
                                clickLeft(mIndex);
                              },
                              iconSize: 48,
                              icon: const Icon(Icons.arrow_left, size: 48)),
                          const Text('DẢI SANG TRÁI')
                        ],
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Text('Score: $score2',
                          style: TextStyle(
                              fontSize: 23,
                              color: currentPlayer == PLAYER_2
                                  ? Colors.lightBlue
                                  : Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Row(
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
                  const SizedBox(width: 16),
                  AbsorbPointer(
                      child: SizedBox(
                          width: itemWidth / 5,
                          height: itemWidth / 5 + itemWidth / 5,
                          child: singleBox(11, listBoard[11].isMandari,
                              isLeft: true)),
                      absorbing: true),
                  SizedBox(
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
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5, childAspectRatio: 1),
                            itemBuilder: (BuildContext context, int index) {
                              return singleBox(
                                  index, listBoard[index].isMandari);
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
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5, childAspectRatio: 1),
                            itemBuilder: (BuildContext context, int index) {
                              return singleBox(
                                  index + 6, listBoard[index + 6].isMandari);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  AbsorbPointer(
                      child: SizedBox(
                          width: itemWidth / 5,
                          height: itemWidth / 5 + itemWidth / 5,
                          child: singleBox(5, listBoard[5].isMandari)),
                      absorbing: true),
                  const SizedBox(width: 16),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          initializeGame();
                        });
                      },
                      icon: const Icon(Icons.restart_alt, size: 36)),
                ],
              ),
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
                            color: currentPlayer == PLAYER_1
                                ? Colors.lightBlue
                                : Colors.black)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (mIndex < 0) return;
                              clickLeft(mIndex);
                            },
                            iconSize: 48,
                            icon: const Icon(Icons.arrow_left)),
                        const Text('DẢI SANG TRÁI')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (mIndex < 0) return;
                              clickRight(mIndex);
                            },
                            iconSize: 48,
                            icon: const Icon(Icons.arrow_right, size: 48)),
                        const Text('DẢI SANG PHẢI')
                      ],
                    ),
                    Text('Score: $score1',
                        style: TextStyle(
                            fontSize: 23,
                            color: currentPlayer == PLAYER_1
                                ? Colors.lightBlue
                                : Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Game process
  Future<void> directLeft_cf(int index) async {
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;

    try {
      while (boc > 0) {
        await Future.delayed(
          const Duration(seconds: 0),
          () {
            setState(() {
              var iYellow = i + 1 == 12 ? 0 : i + 1;
              var iBlue = i == 12 ? 0 : i;
              listBoard[iYellow].color = Colors.yellow;
              print('current i: $iYellow'  );
              print('yellow i: $iYellow'  );
              listBoard[iBlue].color =
                  listBoard[iBlue].isMandari ? Colors.red : Colors.blue;
            });
          },
        );
        boc--;
        i++;
        if (i == 12) i = 0;
        listBoard[i].score++;

        if (boc == 0) {
          // o tiep theo k phai quan va khac 0
          if (!listBoard[i + 1 == 12 ? 0 : i + 1].isMandari &&
              listBoard[i + 1 == 12 ? 0 : i + 1].score != 0) {
            //boc o tiep theo de rai
            i++;
            if (i == 12) i = 0;
            // set color sửa  i + 1 > 11 ? 0 : i + 1 thành i - 1 < 0 ? 11 : i - 1
            listBoard[i - 1 < 0 ? 11 : i - 1].color =
                listBoard[i - 1 < 0 ? 11 : i - 1].isMandari
                    ? Colors.red
                    : Colors.blue;

            boc = listBoard[i].score;
            listBoard[i].score = 0;
          } else {
            listBoard[i].color =
                listBoard[i].isMandari ? Colors.red : Colors.blue;
          }
        }
      }

      //Ăn cờ
      while (listBoard[i + 1 == 12 ? 0 : i + 1].score == 0 &&
          !listBoard[i + 1 == 12 ? 0 : i + 1].isMandari &&
          listBoard[i + 2 == 12 ? 0 : i + 2].score != 0) {
        print('i trc khi ăn : $i');
        i = i + 1 == 12 ? 0 : i + 1;
        i = i + 1 == 12 ? 0 : i + 1;
        print('i sau khi ăn : $i');
        if (listBoard[i].isMandari) score += 10;
        score += listBoard[i].score;
        listBoard[i].score = 0;
      }

      if (currentPlayer == PLAYER_1) {
        score1 += score;
      } else {
        score2 += score;
      }
      changeTurn();
    } catch (e) {}
  }

  Future<void> directRight_cf(int index) async {
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;

    try {
      while (boc > 0) {
        await Future.delayed(
          const Duration(seconds: 0),
          () {
            setState(() {
              var iYellow = i - 1 < 0 ? 11 : i - 1;
              var iBlue = i < 0 ? 11 : i;
              listBoard[iYellow].color = Colors.yellow;
              listBoard[iBlue].color =
                  listBoard[iBlue].isMandari ? Colors.red : Colors.blue;
            });
          },
        );
        boc--;
        i--;
        if (i == -1) i = 11;
        listBoard[i].score++;

        if (boc == 0) {
          // ô tiếp theo k phải quan và ô tiếp theo có điểm số ! = 0 thì bốc tiếp
          if (!listBoard[i - 1 == -1 ? 11 : i - 1].isMandari &&
              listBoard[i - 1 == -1 ? 11 : i - 1].score != 0) {
            i--;
            if (i == -1) i = 11;
            // sửa i - 1 < 0 ? 11 : i - 1 thành i + 1 > 11 ? 0 : i+1 set color
            listBoard[i + 1 > 11 ? 0 : i + 1].color =
                listBoard[i + 1 > 11 ? 0 : i + 1].isMandari
                    ? Colors.red
                    : Colors.blue;

            boc = listBoard[i].score;
            listBoard[i].score = 0;
          } else {
            listBoard[i].color =
                listBoard[i].isMandari ? Colors.red : Colors.blue;
            // IMPORTANT
          }
        }
      }

      // Check ăn cờ
      //ô tiếp theo = 0 và k phải quan và ô tiếp theo nữa khác 0
      while (listBoard[i - 1 == -1 ? 11 : i - 1].score == 0 &&
          !listBoard[i - 1 == -1 ? 11 : i - 1].isMandari &&
          listBoard[i - 2 == -1 ? 11 : i - 2].score != 0) {
        i = i - 1 == -1 ? 11 : i - 1;
        i = i - 1 == -1 ? 11 : i - 1;
        if (listBoard[i].isMandari) score += 10;
        score += listBoard[i].score;
        listBoard[i].score = 0;
      }

      if (currentPlayer == PLAYER_1) {
        score1 += score;
      } else {
        score2 += score;
      }
      changeTurn();
    } catch (e) {}
  }

  void changeTurn() {
    for (int i = 0; i < listBoard.length; i++) {
      listBoard[i].selected = false;
    }
    if (currentPlayer == PLAYER_1) {
      currentPlayer = PLAYER_2;
    } else {
      currentPlayer = PLAYER_1;
    }
  }

  void end() {
    setState(() {
      endGame = true;
    });
  }

  void checkForWin() {
    String msg = '';
    var temp = listBoard.firstWhere((element) => element.isMandari);
    var temp2 = listBoard.lastWhere((element) => element.isMandari);
    if (temp.score == 0 && temp2.score == 0) {
      end();
      if (score1 > score2) {
        msg = 'Người chơi 1 chiến thắng với số điểm $score1'
            '\nNgười chơi 2 thua cuộc với số điểm $score2';
      }
      showGameOverMessage(msg);
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
        ? const BorderRadius.only(
            bottomLeft: Radius.circular(36), topLeft: Radius.circular(36))
        : const BorderRadius.only(
            bottomRight: Radius.circular(36), topRight: Radius.circular(36));
    return InkWell(
      onTap: () {
        if (endGame || listBoard[index].score == 0) return;
        setState(() {
          mIndex = index;
          for (int i = 0; i < listBoard.length; i++) {
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
                : listBoard[index].selected
                    ? Colors.lightBlue
                    : listBoard[index].color,
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
                        fontSize: currentPlayer == PLAYER_2 ? 38 : 0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '${listBoard[index].score}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: currentPlayer == PLAYER_1 ? 38 : 0,
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
      setState(() {
        //rai cho team 1
        score1 -= 5;
        if (score1 < 0) {
          endGame = true;
          return;
        }
        for (int i = 0; i < 5; i++) {
          listBoard[i].score++;
        }
      });
    }
    if (team.compareTo('2') == 0) {
      setState(() {
        //rai cho team 2
        score2 -= 5;
        if (score1 < 0) {
          endGame = true;
          return;
        }
        for (int i = 6; i < 11; i++) {
          listBoard[i].score++;
        }
      });
    }
  }
}
