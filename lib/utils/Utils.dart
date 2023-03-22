import 'package:flutter/material.dart';

class Utils {

  static List<String> teamA = [
    "Nuwan Prasanna",
    "Kusal Munasinghe",
    "Chinthaka Herath",
    "Dulith",
    "Sankalpa Nirmana",
    "Naleen",
    "Sasanka Dahanayake",
    "Kithmi Kanaheraarachchi",
    "Dilusha Sandaruwani"
  ];

  static List<String> teamB = [
    "Tilanka Mihingu",
    "Priyal",
    "Kushan",
    "Chamath",
    "Chalani",
    "Visal Gmage",
    "Pabasara Meegahakumbura",
    "Lihini Rajapaksha"
  ];

  static List<String> teamC = [
    "Riyansi Liyanage",
    "Rasika Suriarachchi",
    "Sadun",
    "Ashoka Pradeep",
    "Thenuka",
    "Achini",
    "Menaka",
    "Manjula"
  ];

  static List<String> teamD = [
    "Manul Binusha",
    "Shamsh",
    "Chatura",
    "sachithra",
    "Prasad",
    "Isuru Wakkumbura",
    "Asiri Dhanapala",
    "Christina Edmund",
    "Dinusha Saratchandra"
  ];


  static List<String>? selectTeam(int id) {
    switch (id) {
      case 1:
        return teamA;
      case 2:
        return teamB;
      case 3:
        return teamC;
      case 4:
        return teamD;
    }
    return null;
  }

  static showErrorDialog(BuildContext context,String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}