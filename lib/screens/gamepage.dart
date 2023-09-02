import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/Components/Showsnackbar.dart';
import 'package:tic_tac_toe/screens/EndScreen.dart';
import 'package:tic_tac_toe/utils/ui/theme.dart';

import '../utils/common.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool xturn = true;
  String marks = '';
  bool gameOver = false;
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  String result = '';
  List<int> winnergame = [];
  int xScore = 0;
  int oScore = 0;
  int filledbox = 0;

  List<List<int>> winningConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  // TextStyle customfont = GoogleFonts.coiny(
  //     textStyle:
  //         TextStyle(letterSpacing: 3, fontSize: 30, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tic tac toe",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: MainColor.primaryColor,
          centerTitle: true,
        ),
        body: Container(
          color: MainColor.primaryColor,
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        padding: EdgeInsets.all(10),
                        decoration: xturn
                            ? BoxDecoration(
                                color: MainColor.secondaryColor,
                                border: Border.all(
                                    color: Colors.amberAccent, width: 2),
                                borderRadius: BorderRadius.circular(20))
                            : BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Player",
                              style: customfont.copyWith(fontSize: 15),
                            ),
                            Text("X", style: customfont.copyWith(fontSize: 50)),
                            Text(
                              xScore.toString(),
                              style: customfont.copyWith(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        padding: EdgeInsets.all(10),
                        decoration: !xturn
                            ? BoxDecoration(
                                color: MainColor.secondaryColor,
                                border: Border.all(
                                    color: Colors.amberAccent, width: 2),
                                borderRadius: BorderRadius.circular(20))
                            : BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Player",
                              style: customfont.copyWith(fontSize: 15),
                            ),
                            Text("O", style: customfont.copyWith(fontSize: 50)),
                            Text(
                              oScore.toString(),
                              style: customfont.copyWith(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        gameOver
                            ? result
                            : xturn
                                ? "Its X Turns"
                                : "Its O Turns",
                        style: customfont,
                      )),
                  Expanded(
                    flex: 6,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 9,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _ontapped(index);
                            _checkRoundWinner(displayXO[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: winnergame.contains(index)
                                    ? MainColor.secondaryColor
                                    : MainColor.accentColor),
                            child: Center(
                              child: Text(
                                displayXO[index],
                                style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                        fontSize: 64,
                                        color: winnergame.contains(index)
                                            ? Colors.purpleAccent
                                            : Colors.amberAccent)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _ontapped(int index) {
    setState(() {
      if (xturn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledbox++;
        xturn = !xturn;
      } else if (!xturn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledbox++;
        xturn = !xturn;
      }
    });
  }

  void _checkRoundWinner(String mark) {
    for (var element in winningConditions) {
      if (displayXO[element[0]] == mark &&
          displayXO[element[1]] == mark &&
          displayXO[element[2]] == mark) {
        result = "${displayXO[element[0]]} is winner";
        gameOver = true;
        winnergame = element;
        showSnackBar(context, "New Game starts in 3 seconds");
        _addscore(displayXO[element[0]]);
        _checkWinner();
      }
    }
    setState(() {
      if (result == '' && filledbox == 9) {
        result = "Its Tie  :)";
        gameOver = true;
        showSnackBar(context, "New Game starts in 3 seconds");
        Future.delayed(const Duration(seconds: 3), _clearBoard);
      }
    });
  }

  void _clearBoard() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
    filledbox = 0;
    winnergame = [];
    result = '';
    gameOver = false;
  }

  void _addscore(String w) {
    setState(() {
      if (w == 'O') {
        oScore++;
      } else if (w == 'X') {
        xScore++;
      }
    });
    Future.delayed(const Duration(seconds: 3), _clearBoard);
  }

  void _checkWinner() {
    if (oScore == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndScreen(winner: result),
          ));
    } else if (xScore == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EndScreen(winner: result),
          ));
    }
  }
}
