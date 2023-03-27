import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:score_board/Screens/StatsPage.dart';
import 'package:score_board/utils/Utils.dart';

class TournamentHistory extends StatefulWidget {
  const TournamentHistory({Key? key}) : super(key: key);

  @override
  State<TournamentHistory> createState() => _TournamentHistoryState();
}

class _TournamentHistoryState extends State<TournamentHistory> {
  late DatabaseReference _dbRefScore;

  @override
  void initState() {
    // TODO: implement initState
    _dbRefScore = FirebaseDatabase.instance.ref('currentMatchScore');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dbRefScore.onValue,
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
    var dataValues = data.snapshot.value!;
    Map<dynamic, dynamic> childObjects = data.snapshot.value!;
    List<String> keys = data.snapshot.value.keys.toList();

    print(keys);
    print("childObjects");
    print(childObjects);
    print("dataValues");
    print(dataValues[keys[0]]);
    var entry = childObjects.entries.elementAt(0);
    print(childObjects);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tournament History'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.stacked_bar_chart_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MatchStatistics()));
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              var match = dataValues[keys[index]];
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Utils.getTeamLogo(keys[index][0]),
                          width: 100,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              Utils.selectTeamMatch(keys[index]),
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Score ${match['score']}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Balls ${match['balls']}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Wickets ${match['wickets']}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 5,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          Utils.getTeamLogo(
                              keys[index][keys[index].length - 1]),
                          width: 100,
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 5,
                      color: Colors.green,
                    )
                  ],
                ),
              );
            }));
  }
}
