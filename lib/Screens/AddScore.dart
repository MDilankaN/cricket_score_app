import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:score_board/Screens/EditScore.dart';

import '../utils/Utils.dart';

class AddScore extends StatefulWidget {
  String Batting;
  var Team1;
  var Team2;

  AddScore(
      {Key? key,
      required this.Team1,
      required this.Team2,
      required this.Batting})
      : super(key: key);

  @override
  State<AddScore> createState() => _AddScoreState();
}

List<String> teamA = [
  "Nuwan Prasanna",
  "Kusal Munasinghe",
  "Chinthaka Herath",
  "Dulith",
  "Sankalpa Nirmana",
  "Naleen",
  "Sasanka Dahanayake",
  "Kithmi Kanaheraarachchi",
  "Dilusha Sandaruwani"
];

List<String> teamB = [
  "Tilanka Mihingu",
  "Priyal",
  "Kushan",
  "Chamath",
  "Chalani",
  "Visal Gmage",
  "Pabasara Meegahakumbura",
  "Lihini Rajapaksha"
];

List<String> teamC = [
  "Riyansi Liyanage",
  "Rasika Suriarachchi",
  "Sadun",
  "Ashoka Pradeep",
  "Thenuka",
  "Achini",
  "Menaka",
  "Manjula"
];

List<Map> scoreList = [
  {"name": "0", "value": 0},
  {"name": "1", "value": 1},
  {"name": "2", "value": 2},
  {"name": "3", "value": 3},
  {"name": "4", "value": 4},
  {"name": "6", "value": 6},
  {"name": "Wide", "value": 2},
  {"name": "No-ball", "value": 2},
  {"name": "W", "value": 0},
];
List<String> teamD = [
  "Manul Binusha",
  "Shamsh",
  "Chatura",
  "sachithra",
  "Prasad",
  "Isuru Wakkumbura",
  "Asiri Dhanapala",
  "Christina Edmund",
  "Dinusha Saratchandra"
];

class _AddScoreState extends State<AddScore> {
  var battingTeam;
  var bowlingTeam;

  String? _batsman1;
  String? _batsman2;
  String? _bowler;

  late String path;

  late DatabaseReference _dbRef;
  late DatabaseReference _dbRef2;
  late DatabaseReference _dbRefScore;

  @override
  void initState() {
    super.initState();
    setState(() {
      path = "${widget.Team1[0]['id']}VS${widget.Team2[0]['id']}";
    });

    print(path);
    _dbRef = FirebaseDatabase.instance.ref(path);
    _dbRef2 = FirebaseDatabase.instance.ref("currentMatchScore");
    _dbRefScore = FirebaseDatabase.instance.ref("currentMatchScore");

    setState(() {
      if (widget.Batting == 'team1') {
        battingTeam = selectTeam(widget.Team1[0]['id']);
        bowlingTeam = selectTeam(widget.Team2[0]['id']);
      } else {
        battingTeam = selectTeam(widget.Team2[0]['id']);
        bowlingTeam = selectTeam(widget.Team1[0]['id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Score'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditScore(
                          path: path,
                          title:
                              "${widget.Team1[0]['name']} VS ${widget.Team2[0]['name']}")));
            },
          )
        ],
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
                      widget.Team1[0]['logo'],
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.Team1[0]['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 25),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: Text(
                    'Vs',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      widget.Team2[0]['logo'],
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.Team2[0]['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 25),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 5,
          ),
          SizedBox(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Batsman 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton(
                    value: _batsman1,
                    hint: Text("Select 1st Batsman"),
                    items: battingTeam.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _batsman1 = value as String?;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Batsman 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton(
                    value: _batsman2,
                    hint: Text("Select 2nd Batsman"),
                    items: battingTeam.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _batsman2 = value as String?;
                      });
                    }),
              ],
            ),
          ),
          SizedBox(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bowler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 35,
                ),
                DropdownButton(
                    value: _bowler,
                    hint: Text("Select Bowler"),
                    items: bowlingTeam.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _bowler = value as String?;
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 400,
            height: 400,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children: scoreList.map((score) {
                return ElevatedButton(
                  onPressed: () {
                    if (_batsman1 == null) {
                      Utils.showErrorDialog(context, 'Select Batsman 1');
                    } else if (_batsman2 == null) {
                      Utils.showErrorDialog(context, 'Select Batsman 2');
                    } else if (_bowler == null) {
                      Utils.showErrorDialog(context, 'Select Bowler');
                    } else {
                      _addToDB(_batsman1!, _batsman2!, _bowler!, score["value"],
                          score["name"] == "W" ? 1 : 0);
                    }
                  },
                  child: Text(
                    score['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: () {}, child: Text("End Match"))
        ],
      ),
    );
  }

  List<String>? selectTeam(int id) {
    switch (id) {
      case 1:
        return teamA;
      case 2:
        return teamB;
      case 3:
        return teamC;
      case 4:
        return teamD;
    }
    return null;
  }

  void _addToDB(String batsman1, String batsman2, String bowler, int mark,
      int wicket) async {
    var total = 0;
    var wickets = 0;
    var ball = 1;
    try {
      var time = DateTime.now().toString();
      await _dbRef.child("match").push().set({
        'batsman1': batsman1,
        'batsman2': batsman2,
        'bowler': bowler,
        'point': mark,
        'time': time
      });

      _dbRef2.push().set({
        'score': total + mark,
        'wickets': wickets + wicket,
        'balls': ball++,
        "path": path,
      });

      // _dbRefScore.child('score').r

      print('Data added successfully');
    } catch (error) {
      print('Error adding data: $error');
    }
  }

  void updateScore() {}
}
