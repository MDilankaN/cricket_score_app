import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'EditTile.dart';

class LiveScores extends StatefulWidget {
  String path;

  LiveScores({Key? key, required this.path}) : super(key: key);

  @override
  State<LiveScores> createState() => _LiveScoresState();
}

class _LiveScoresState extends State<LiveScores> {
  late DatabaseReference _dbRef;

  // late Map<dynamic, dynamic> childObjects;

  @override
  void initState() {
    _dbRef = FirebaseDatabase.instance.ref(widget.path);
    super.initState();
  }

  // void _setState() {
  //   // Call setState() to trigger a rebuild of the widget tree
  //   setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _dbRef.onChildAdded,
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
    Map<dynamic, dynamic> childObjects = data.snapshot.value!;
    List<String> keys = data.snapshot.value.keys.toList();

    return Center(
      child: ListView.builder(
          itemCount: childObjects.length,
          itemBuilder: (BuildContext context, int index) {
            var entry = childObjects.entries.elementAt(index);
            return Column(
              children: [
                ListTile(
                  title: Text(entry.value['batsman1']),
                ),

                const Divider(
                  height: 2,
                  thickness: 2,
                )
              ],
            );
          }),
    );
  }
}
