import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class MatchStatisticsBatsmen extends StatefulWidget {
  const MatchStatisticsBatsmen({Key? key}) : super(key: key);

  @override
  State<MatchStatisticsBatsmen> createState() => _MatchStatisticsStateBatsmen();
}

class _MatchStatisticsStateBatsmen extends State<MatchStatisticsBatsmen> {
  late DatabaseReference _dbRefBatsmen;

  @override
  void initState() {
    _dbRefBatsmen = FirebaseDatabase.instance.ref("batsmen");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: _dbRefBatsmen.onValue,
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
    List<String> keys = data.snapshot.value.keys.toList();

    print(dataValues[keys[0]]['Wickets'].toString());

    return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(keys[index], style: TextStyle(fontSize: 16),),
              const SizedBox(
                width: 20,
              ),
              Text(dataValues[keys[index]]['score'].toString(), style: TextStyle(fontSize: 16),)
            ],
          );
        });


  }
}
