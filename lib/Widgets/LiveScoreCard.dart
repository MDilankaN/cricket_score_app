import 'package:flutter/material.dart';

class LiveScoreCard extends StatelessWidget {
  var data;

  LiveScoreCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Batsman ${data.value['batsman1']}"),
                data.value['out'] ? Text(" (out)") : Text("*"),
              ],
            ),
            Text("Bowler  ${data.value['bowler']}"),
          ],
        ),
        Column(
          children: [
            Text("Score ${data.value['point']}"),
          ],
        )
      ],
    );
  }
}
