import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:score_board/Screens/ViewScore.dart';
import 'package:score_board/utils/Utils.dart';

import 'AddScore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum battingTeam { team1, team2 }

class _HomeState extends State<Home> {
  late DatabaseReference _dbRef;

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref('currentMatch');
  }

  int? _isSelectedTeam1;
  int? _isSelectedTeam2;
  battingTeam _whichTeamBatting = battingTeam.team1;

  List<Map> teamList = [
    {'id': 1, 'name': 'Hit Squad', 'logo': 'assets/logos/HitSquad.png'},
    {'id': 2, 'name': 'Zorro Zebras', 'logo': 'assets/logos/ZorroZebras.png'},
    {
      'id': 3,
      'name': 'ZorroCyclones',
      'logo': 'assets/logos/ZorroCyclones.png'
    },
    {'id': 4, 'name': 'Zeagles', 'logo': 'assets/logos/Zeagles.png'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create a Match',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text('Select Cricket Teams', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButtonHideUnderline(
                          child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          hint: const Text("Select Team 1"),
                          value: _isSelectedTeam1,
                          onChanged: (newValue) {
                            setState(() {
                              _isSelectedTeam1 = newValue as int?;
                            });
                          },
                          items: teamList.map((team) {
                            return DropdownMenuItem(
                                value: team['id'],
                                child: Row(
                                  children: [
                                    Image.asset(
                                      team['logo'],
                                      width: 40,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(team['name'])
                                  ],
                                ));
                          }).toList(),
                        ),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButtonHideUnderline(
                          child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          hint: const Text("Select Team 2"),
                          value: _isSelectedTeam2,
                          onChanged: (newValue) {
                            setState(() {
                              _isSelectedTeam2 = newValue as int?;
                            });
                          },
                          items: teamList.map((team) {
                            return DropdownMenuItem(
                                value: team['id'],
                                child: Row(
                                  children: [
                                    Image.asset(
                                      team['logo'],
                                      width: 40,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(team['name'])
                                  ],
                                ));
                          }).toList(),
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Select Batting Team', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ListTile(
                          title: const Text('Team 1'),
                          leading: Radio<battingTeam>(
                              value: battingTeam.team1,
                              groupValue: _whichTeamBatting,
                              onChanged: (battingTeam? value) {
                                setState(() {
                                  _whichTeamBatting = value!;
                                });
                              }),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ListTile(
                          title: const Text('Team 2'),
                          leading: Radio<battingTeam>(
                              value: battingTeam.team2,
                              groupValue: _whichTeamBatting,
                              onChanged: (battingTeam? value) {
                                setState(() {
                                  _whichTeamBatting = value!;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(
                            200, 50), // set the width and height of the button
                      ),
                    ),
                    onPressed: () {
                      if (_isSelectedTeam1 == null ||
                          _isSelectedTeam2 == null) {
                        Utils.showErrorDialog(context, 'Must select a Team..!');
                      } else if (_isSelectedTeam1 == _isSelectedTeam2) {
                        Utils.showErrorDialog(context, 'Same Team Selected..!');
                      } else {
                        try {
                          _createCurrentMatchDB(
                              _isSelectedTeam1!,
                              _isSelectedTeam2!,
                              _whichTeamBatting.name,
                              "${_isSelectedTeam1}VS${_isSelectedTeam2}");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => AddScore(
                                        Team1: teamList
                                            .where((team) =>
                                                team['id'] == _isSelectedTeam1)
                                            .toList(),
                                        Team2: teamList
                                            .where((team) =>
                                                team['id'] == _isSelectedTeam2)
                                            .toList(),
                                        Batting: _whichTeamBatting.name,
                                      ))));
                        } catch (e) {
                          print("Error");
                        }
                      }
                    },
                    child: const Text("Create Match"),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Divider(
                height: 2,
                thickness: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'View Score',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(
                            200, 50), // set the width and height of the button
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ViewScore())));
                    },
                    child: const Text(
                      'View Score',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _createCurrentMatchDB(int team1, int team2, String bat, String path) {
    var time = DateTime.now().toString();
    _dbRef.set({
      'Team1': team1,
      'Team2': team2,
      'FirstBat': bat,
      'time': time,
      "path": path,
    });
  }
}
