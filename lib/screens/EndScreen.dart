import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/common.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key, required this.winner});

  final String winner;
  static route() => MaterialPageRoute(builder: (context) => const EndScreen(winner: '',));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          children: [
            Text(winner,style: customfont,),
          ],
        )
      ),
    );
  }
}
