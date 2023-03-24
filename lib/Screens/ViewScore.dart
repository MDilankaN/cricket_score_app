import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:score_board/Widgets/LiveScores.dart';
import 'package:score_board/utils/Utils.dart';
import 'dart:async';

import '../Widgets/LiveScoreTile.dart';

class ViewScore extends StatefulWidget {
  const ViewScore({Key? key}) : super(key: key);

  @override
  State<ViewScore> createState() => _ViewScoreState();
}

class _ViewScoreState extends State<ViewScore> {
  late DatabaseReference _dbRef;
  late DatabaseReference _dbRefScore;

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref('currentMatch');
    _dbRefScore = FirebaseDatabase.instance.ref('currentMatchScore');
  }

  void _setState() {
    // Call setState() to trigger a rebuild of the widget tree
    setState(() {});
  }

  // static const oneSec = Duration(seconds:1);
  // Timer.periodic(oneSec, (timer) {
  // _setState();
  // });


  @override
  Widget build(BuildContext context) {

    print(_dbRef);
    return StreamBuilder(
        stream: _dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return handelSnapshotData(snapshot.data);
          }
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error.toString()}');
          }
          if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
            return const Center(
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            );
          } else {
            return const Center(child: Text('No data found.'));
          }
        });
  }

  Widget handelSnapshotData(var data) {
    Map<dynamic, dynamic> dataValues = data.snapshot.value!;

    // if (dataValues == null) {
    //   return Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Score Board'),
    //       ),
    //       body: const Center(
    //         child: Text('No Match Found.'),
    //       ));
    // }

    var team1Members = Utils.selectTeam(dataValues['Team1']);
    var team2Members = Utils.selectTeam(dataValues['Team2']);
    var team1Data = Utils.teamList
        .where((team) => team['id'] == dataValues['Team1'])
        .toList();
    var team2Data = Utils.teamList
        .where((team) => team['id'] == dataValues['Team2'])
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Score Board'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        team1Data[0]['logo'],
                        width: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        team1Data[0]['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                    child: Text(
                      'Vs',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        team2Data[0]['logo'],
                        width: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        team2Data[0]['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 440,
                child: LiveScoreTile(dbRef: _dbRefScore, path:dataValues['path'] ),
              ),
            ),
            const Divider(
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 10),
              child: SizedBox(
                  height: 200,
                  child: LiveScores(
                    path: dataValues['path'],
                  )),
            ),
          ],
        ));
  }
}
