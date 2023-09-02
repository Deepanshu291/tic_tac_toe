

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/Components/Showsnackbar.dart';

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
  String winner = '';
  List<int> winnergame = [];
  int xScore = 0;
  int oScore = 0;

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

  TextStyle customfont = GoogleFonts.coiny(
      textStyle:
          TextStyle(letterSpacing: 3, fontSize: 30, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tic tac toe",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.deepPurple,
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("PLayer O", style: customfont),
                              Text(
                                xScore.toString(),
                                style: customfont,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "PLayer O",
                                style: customfont,
                              ),
                              Text(
                                oScore.toString(),
                                style: customfont,
                              )
                            ],
                          )
                        ],
                      )),
                  Expanded(
                    flex: 6,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _ontapped(index);
                            _checkWinner(displayXO[index]);
                          },
                          child: Container(
                            // height: 1,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: winnergame.contains(index)
                                    ? Colors.deepPurpleAccent
                                    : Colors.yellow.shade600),
                            child: Center(
                              child: Text(
                                displayXO[index],
                                style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                        fontSize: 64,
                                        color: winnergame.contains(index)
                                            ? Colors.purpleAccent
                                            : Colors.redAccent)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        winner ,
                        style: customfont,
                      ))
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
        xturn = !xturn;
      } else if (!xturn && displayXO[index] == '') {
        displayXO[index] = 'O';
        xturn = !xturn;
      }
    });
  }

  void _checkWinner(String mark) {
    for (var element in winningConditions) {
      if (displayXO[element[0]] == mark &&
          displayXO[element[1]] == mark &&
          displayXO[element[2]] == mark) {
        String content = displayXO[element[0]] + " is winner";
        winner = content;
        showSnackBar(context, content);
        winnergame = element;
        _addscore(displayXO[element[0]]);
      }
    }
  }

  void _clearBoard() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });

    winnergame = [];
    winner = '';
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
}
