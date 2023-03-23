import 'package:flutter/material.dart';

class LiveScoreTile extends StatelessWidget {
  var dbRef;
  var path;
   LiveScoreTile({Key? key, required this.dbRef, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dbRef.child(path).onValue,
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
    var dataValues = data.snapshot.value!;

    return Column(
      children: [
        Text("Score   ${dataValues['score']} / ${dataValues['wickets']}", style:  TextStyle(fontSize: 25),),
        Text('Overs   ${ballsToOvers(dataValues['balls'])}'),

      ],
    );
  }

  double ballsToOvers(int balls) {
    double overs = balls / 6;
    overs = double.parse(overs.toStringAsFixed(1)); // round to one decimal place
    return overs;
  }
}
