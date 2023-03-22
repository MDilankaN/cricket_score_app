import 'package:flutter/material.dart';

class EditMatchTiles extends StatelessWidget {
  var data;
  var dbInstance;
  var keyVal;


  EditMatchTiles({Key? key, required this.data, required this.keyVal, required this.dbInstance}) : super(key: key);



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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Batsman 2 - ${data.value['batsman2']}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bowler - ${data.value['bowler']}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
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
                style: TextStyle(fontSize: 16),
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
                        print(keyVal);
                      },
                      icon: Icon(Icons.delete_outline_rounded,color: Colors.red,)),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined,color: Colors.green,)),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
