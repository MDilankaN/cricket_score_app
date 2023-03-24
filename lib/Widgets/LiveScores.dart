import 'dart:async';
import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:score_board/Widgets/LiveScoreCard.dart';

import 'EditTile.dart';

// class LiveScores extends StatefulWidget {
//   String path;
//
//   LiveScores({Key? key, required this.path}) : super(key: key);
//
//   @override
//   State<LiveScores> createState() => _LiveScoresState();
// }
//
// class _LiveScoresState extends State<LiveScores> {
//   late DatabaseReference _dbRef;
//
//   // late Map<dynamic, dynamic> childObjects;
//
//   @override
//   void initState() {
//     _dbRef = FirebaseDatabase.instance.ref(widget.path);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: _dbRef.onChildAdded,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             print(snapshot.data);
//             return handelSnapshotData(snapshot.data);
//           }
//           if (snapshot.hasError) {
//             return Text('Error ${snapshot.error.toString()}');
//           }
//           if (!snapshot.hasData) {
//             return const Center(
//               child: SizedBox(
//                   width: 30, height: 30, child: CircularProgressIndicator()),
//             );
//           } else {
//             return const Center(child: Text('No data found.'));
//
//           }
//
//
//         });
//   }
//
//   Widget handelSnapshotData(var data) {
//     Map<dynamic, dynamic> childObjects = data.snapshot.value!;
//     List<String> keys = data.snapshot.value.keys.toList();
//
//     return Center(
//       child: ListView.builder(
//           itemCount: childObjects.length,
//           itemBuilder: (BuildContext context, int index) {
//             var entry = childObjects.entries.elementAt(index);
//             return Column(
//               children: [
//                 ListTile(
//                   title: Text(entry.value['batsman1']),
//                 ),
//                 const Divider(
//                   height: 2,
//                   thickness: 2,
//                 )
//               ],
//             );
//           }),
//     );
//   }
// }

class LiveScores extends StatelessWidget {
  String path;
  late DatabaseReference _dbRef;

  LiveScores({Key? key, required this.path}) {
    _dbRef = FirebaseDatabase.instance.ref(path);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dbRef.child('match').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return handelSnapshotData(snapshot.data);
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error.toString()}');
          } else if (!snapshot.hasData) {
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
    Map<dynamic, dynamic> childObjects = data.snapshot.value!;
    List<String> keys = data.snapshot.value.keys.toList();

    print(childObjects);

    return Center(
      child: ListView.builder(
          itemCount: childObjects.length,
          itemBuilder: (BuildContext context, int index) {
            var entry = childObjects.entries.elementAt(index);
            return Column(
              children: [
                LiveScoreCard(data: entry),
                const Divider(
                  height: 2,
                  thickness: 2,
                ),
                SizedBox(
                  height: 2,
                )
              ],
            );
          }),
    );
  }
}
