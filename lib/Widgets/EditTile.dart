import 'package:flutter/material.dart';

class EditMatchTiles extends StatelessWidget {
  var data;
  var dbInstance;
  var keyVal;
  final Function() rebuild;

  EditMatchTiles(
      {Key? key,
      required this.data,
      required this.keyVal,
      required this.dbInstance,
      required this.rebuild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Batsman - ${data.value['batsman1']}",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Batsman 2 - ${data.value['batsman2']}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bowler - ${data.value['bowler']}",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Time - ${data.value['time']}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Points - ${data.value['point']}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        try {
                          dbInstance.child("match").child(keyVal).remove();
                          rebuild();
                        } catch (e) {
                          print(e);
                        }
                        print(keyVal);
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.green,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
