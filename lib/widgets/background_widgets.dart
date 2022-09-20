import 'dart:async';

import 'package:flutter/material.dart';

import '../models/box.dart';

class Background extends StatefulWidget {
  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  static const String PLAYER_1 = "Người chơi 1";
  static const String PLAYER_2 = "Người chơi 2";
  int Score1 = 0;
  int Score2 = 0;
  late bool endGame;
  late String currentPlayer;
  late List<Box> listBoard;

  void initializeGame() {
    currentPlayer = PLAYER_1;
    endGame = false;
    Score1 = 0;
    Score2 = 0;

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
    // TODO: implement initState
    initializeGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('=================');
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: (deviceSize.height / 5) - 50,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Player 2',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color:
                        currentPlayer == PLAYER_2 ? Colors.red : Colors.black),
              ),
              Text('Score: $Score2',
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Row(
          children: [
            Container(
                width: 90,
                height: 130,
                child: singleBox(11, listBoard[11].isMandari)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (BuildContext context, int index) {
                      print(
                          '============= ${listBoard[index].color.toString()}');
                      return singleBox(index, listBoard[index].isMandari);
                    },
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    reverse: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (BuildContext context, int index) {
                      print(
                          '============= ${listBoard[index].color.toString()}');
                      return singleBox(
                          index + 6, listBoard[index + 6].isMandari);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: 90,
                height: 130,
                child: singleBox(5, listBoard[5].isMandari)),
          ],
        ),
        // Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 20),
        //     width: double.infinity,
        //     height: deviceSize.height * 0.45 + 30,
        //     decoration: BoxDecoration(
        //         border: Border.all(width: 1, color: Colors.black87),
        //         borderRadius: BorderRadius.circular(15)),
        //     // GridView.builder(
        //     //     itemBuilder: 10,
        //     //     gridDelegate: ,
        //     //     crossAxisCount: 5,
        //     //     mainAxisSpacing: 20,
        //     //     crossAxisSpacing: 20,
        //     //     childAspectRatio: 1,
        //     //     children: [
        //     //       ...listBoard.map((e) {
        //     //         return singleBox(listBoard.indexOf(e), e.isMandari);
        //     //       })
        //     //     ]),
        //     ),
        SizedBox(
          height: deviceSize.height / 5,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Player 1',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: currentPlayer == PLAYER_1
                          ? Colors.red
                          : Colors.black)),
              Text('Score: $Score1',
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      initializeGame();
                    });
                  },
                  icon: const Icon(Icons.restart_alt))
            ],
          ),
        ),
      ],
    )));
  }

  var stop = false;

  // Game process
  void directLeft_cf(int index) {

    stop = false;
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;

    Timer.periodic(Duration(seconds: 1), (timer) {
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
            if (!listBoard[i + 1 == 12 ? 0 : i + 1].isMandari &&
                listBoard[i + 1 == 12 ? 0 : i + 1].score != 0) {
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
            Score1 = score;
          } else {
            Score2 = score;
          }
        }
      } catch (e) {
        timer.cancel();
      }
    });

    // =======================
    // while (boc > 0)  {
    //   boc--;
    //   i++;
    //   print('$i');
    //
    //   if (i == 12) i = 0;
    //   listBoard[i].score++;
    //   if (boc == 0) {
    //     if (!listBoard[i + 1 == 12 ? 0 : i + 1].isMandari &&
    //         listBoard[i + 1 == 12 ? 0 : i + 1].score != 0) {
    //       i++;
    //       if (i == 12) i = 0;
    //       boc = listBoard[i].score;
    //       listBoard[i].score = 0;
    //     }
    //   }
    // }
    // while (listBoard[i + 1 == 12 ? 0 : i + 1].score == 0 &&
    //     listBoard[i + 2 == 12 ? 0 : i + 2].score != 0 &&
    //     !listBoard[i + 1 == 12 ? 0 : i + 1].isMandari) {
    //   i = i + 1 == 12 ? 0 : i + 1;
    //   i = i + 1 == 12 ? 0 : i + 1;
    //   if (listBoard[i].isMandari) score += 9;
    //   score += listBoard[i].score;
    //   listBoard[i].score = 0;
    // }
    //
    // if (currentPlayer == PLAYER_1) {
    //   Score1 = score;
    // } else {
    //   Score2 = score;
    // }
  }

  void directRight_cf(int index) {
    stop = false;
    int boc = listBoard[index].score;
    int i = index;
    int score = 0;
    listBoard[index].score = 0;

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      if (boc > 0) {
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
        Score1 = score;
      } else {
        Score2 = score;
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
      if (Score1 > Score2) {
        msg = 'Người chơi 1 chiến thắng với số điểm $Score1'
            '\nNgười chơi 2 thua cuộc với số điểm $Score2';
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

  Widget singleBox(index, bool isMandari) {
    if(index > 5&& index < 11) {
      index = 11- index +5;
    }
    if (currentPlayer == PLAYER_1) {
      return InkWell(
        onTap: listBoard[index].score == 0 || index < 5
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
                                if (endGame) return;
                                Navigator.of(context).pop();
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
        splashColor: Colors.redAccent,
        highlightColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              color: listBoard[index].score == 0
                  ? Colors.grey
                  : (listBoard[index].color),
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
    } else {
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
        splashColor: Colors.redAccent,
        highlightColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              color: listBoard[index].score == 0
                  ? Colors.grey
                  : (listBoard[index].isMandari ? Colors.red : Colors.blue),
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
    }
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
      Score1 -= 5;
      if (Score1 < 0) {
        endGame = true;
        return;
      }
      for (int i = 0; i < 5; i++) {
        listBoard[i].score++;
      }
    }
    if (team.compareTo('2') == 0) {
      //rai cho team 2
      Score2 -= 5;
      if (Score1 < 0) {
        endGame = true;
        return;
      }
      for (int i = 6; i < 11; i++) {
        listBoard[i].score++;
      }
    }
  }
}
