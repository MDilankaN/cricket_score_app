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

List<Map> scoreList = [
  {"name": "0", "value": 0, "color": Colors.green},
  {"name": "1", "value": 1, "color": Colors.green},
  {"name": "2", "value": 2, "color": Colors.green},
  {"name": "3", "value": 3, "color": Colors.green},
  {"name": "4", "value": 4, "color": Colors.green},
  {"name": "6", "value": 6, "color": Colors.green},
  {"name": "Wide", "value": 4, "color": Colors.orange},
  {"name": "No-ball", "value": 2, "color": Colors.orange},
  {"name": "Wicket", "value": 0, "color": Colors.red},
];

class _AddScoreState extends State<AddScore> {
  var battingTeam;
  var bowlingTeam;

  String? _batsman1;
  String? _bowler;

  late String path;

  late DatabaseReference _dbRef;
  late DatabaseReference _dbRef2;

  @override
  void initState() {
    super.initState();
    setState(() {
      path = "${widget.Team1[0]['id']}VS${widget.Team2[0]['id']}";
    });

    print(path);
    _dbRef = FirebaseDatabase.instance.ref(path);
    _dbRef2 = FirebaseDatabase.instance.ref("currentMatchScore");

    setState(() {
      if (widget.Batting == 'team1') {
        battingTeam = Utils.selectTeam(widget.Team1[0]['id']);
        bowlingTeam = Utils.selectTeam(widget.Team2[0]['id']);
      } else {
        battingTeam = Utils.selectTeam(widget.Team2[0]['id']);
        bowlingTeam = Utils.selectTeam(widget.Team1[0]['id']);
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Batsman',
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
                SizedBox(width: 20,),
                SizedBox(
                  height: 100,
                  child: Column(
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
                  style: ElevatedButton.styleFrom(primary: score["color"]),
                  onPressed: () {
                    if (_batsman1 == null) {
                      Utils.showErrorDialog(context, 'Select Batsman 1');
                    } else if (_bowler == null) {
                      Utils.showErrorDialog(context, 'Select Bowler');
                    } else {
                      _addToDB(_batsman1!, _bowler!, score["value"],score["name"],
                          score["name"] == "Wicket" ? true : false);
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

  void _addToDB(String batsman1, String bowler, int mark, String name,
      bool wicket) async {
    try {
      var time = DateTime.now().toString();
      await _dbRef.child("match").push().set({
        'batsman1': batsman1,
        'out': wicket,
        'wicket_count': wicket ? 1 : 0,
        'bowler': bowler,
        'point': mark,
        'time': time
      });


      _dbRef2.child(path).update({
        'score': ServerValue.increment(mark),
        'wickets': ServerValue.increment(wicket ? 1 : 0) ,
        'balls': ServerValue.increment(name == 'No-bal' ? 0 : 1),
      });

      print('Data added successfully');
    } catch (error) {
      print('Error adding data: $error');
    }
  }

}
