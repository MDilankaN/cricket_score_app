import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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
          } else {
            return const Center(
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget handelSnapshotData(DatabaseEvent? data) {
    var dataValues = data?.snapshot.value;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Score Board'),
        ),
        body: Center(
          // child: ListView.builder(
          //     itemCount: dataValues?.length ?? 0,
          //     itemBuilder: itemBuilder),
        ));
  }
}
