import 'package:flutter/material.dart';

class LiveScoreCard extends StatelessWidget {
  var data;

  LiveScoreCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);

    return Container(
      decoration: BoxDecoration(
          color:
              data.value['out'] ? Colors.red.shade200 : Colors.green.shade100),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "${data.value['batsman1']}",
                    style: TextStyle(fontSize: 30),
                  ),
                  data.value['out']
                      ? Text(
                          " (out)",
                          style: TextStyle(fontSize: 30),
                        )
                      : Text(
                          "*",
                          style: TextStyle(fontSize: 30),
                        ),
                ],
              ),
              // Text("Bowler  ${data.value['bowler']}", style: TextStyle(fontSize: 30),),
            ],
          ),
          Column(
            children: [
              Text(
                "${data.value['point']}",
                style: TextStyle(fontSize: 30),
              ),
            ],
          )
        ],
      ),
    );
  }
}
