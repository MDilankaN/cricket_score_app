import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:score_board/Widgets/StatsPageBatsmen.dart';
import 'package:score_board/Widgets/StatsPageBowlers.dart';

class MatchStatistics extends StatefulWidget {
  const MatchStatistics({Key? key}) : super(key: key);

  @override
  State<MatchStatistics> createState() => _MatchStatisticsState();
}

class _MatchStatisticsState extends State<MatchStatistics> {
  late DatabaseReference _dbRefBowlers;

  @override
  void initState() {
    _dbRefBowlers = FirebaseDatabase.instance.ref("bowlers");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Stats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text("Match Statistics of Batsmen / Batswomen", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  SizedBox(
                      height: 200, width: 200, child: MatchStatisticsBatsmen()),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  Text("Match Statistics of Bowlers", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  SizedBox(
                      height: 200, width: 200, child: MatchStatisticsBowlers()),
                ],
              ),
            ],
          ),
          // child: Column(
          //   children: [
          //     Row(
          //       children: [
          //         MatchStatisticsBowlers(),
          //         // SizedBox(width: 10,),
          //         // MatchStatisticsBatsmen()
          //       ],
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
