import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:score_board/Widgets/EditTile.dart';

class EditScore extends StatefulWidget {
  String? path;
  String? title;

  EditScore({Key? key, required this.path, required this.title})
      : super(key: key);

  @override
  State<EditScore> createState() => _EditScoreState();
}

class _EditScoreState extends State<EditScore> {
  late DatabaseReference _dbRef;
  late DatabaseReference _dbRefTotal;

  @override
  void initState() {
    print(widget.path);
    _dbRef = FirebaseDatabase.instance.ref(widget.path);
    _dbRefTotal = FirebaseDatabase.instance.ref('currentMatchScore');
    super.initState();
  }

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
    // Map<String, Map<String, dynamic>> childObjects = data.snapshot.value!;
    Map<dynamic, dynamic> childObjects = data.snapshot.value!;
    List<String> keys = data.snapshot.value.keys.toList();
    print(keys);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: childObjects.length,
              itemBuilder: (BuildContext context, int index) {
                var entry = childObjects.entries.elementAt(index);
                return Column(
                  children: [
                    EditMatchTiles(
                      data: entry,
                      path: widget.path,
                      dbInstance: _dbRef,
                      keyVal: keys[index],
                      rebuild:   _setState,
                       markTotalDBref: _dbRefTotal
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                    )
                  ],
                );
              }),
        ));
  }

  void _setState() {
    // Call setState() to trigger a rebuild of the widget tree
    setState(() {});
  }
}
