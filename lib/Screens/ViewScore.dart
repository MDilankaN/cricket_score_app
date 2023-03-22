import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:score_board/Widgets/LiveScores.dart';
import 'package:score_board/utils/Utils.dart';

class ViewScore extends StatefulWidget {
  const ViewScore({Key? key}) : super(key: key);

  @override
  State<ViewScore> createState() => _ViewScoreState();
}

class _ViewScoreState extends State<ViewScore> {
  late DatabaseReference _dbRef;

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref('currentMatch');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return handelSnapshotData(snapshot.data);
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error.toString()}');
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          } else {
            return const Center(
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget handelSnapshotData(var data) {
    Map<dynamic, dynamic> dataValues = data.snapshot.value!;

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
            const Divider(
              thickness: 5,
            ),
            SizedBox(
              height: 400,
                child: LiveScores(path: dataValues['path'])),
          ],
        ));
  }
}
