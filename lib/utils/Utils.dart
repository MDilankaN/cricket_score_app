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

  static bool isFirstLastLetterEqual(String str1, String str2) {
    if (str1.isEmpty || str2.isEmpty) {
      return false;
    }

    String firstLetterOfString1 = str1[0];
    String firstLetterOfString2 = str2[0];
    String lastLetterOfString1 = str1[str1.length - 1];
    String lastLetterOfString2 = str2[str2.length - 1];

    return firstLetterOfString1 == lastLetterOfString2 &&
        firstLetterOfString2 == lastLetterOfString1;
  }

  static String selectTeamMatch(String matchPath) {
    String name = '';
    if (matchPath.isEmpty) {
      return 'matchPath';
    }
    String firstLetterOfString = matchPath[0];
    String lastLetterOfString = matchPath[matchPath.length - 1];

    name =
        "${getTeamName(firstLetterOfString)} VS ${getTeamName(lastLetterOfString)}";

    return name;
  }

  static String getTeamName(String number) {
    switch (number) {
      case '1':
        return 'Hit Squad';
      case '2':
        return 'Zorro Zebras';
      case '3':
        return 'ZorroCyclones';
      case '4':
        return 'Zeagles';
      default:
        return '';
    }
  }

  static String getTeamLogo(String id) {

    switch (id) {
      case "1":
        return 'assets/logos/HitSquad.png';
      case "2":
        return 'assets/logos/ZorroZebras.png';
      case "3":
        return 'assets/logos/ZorroCyclones.png';
      case "4":
        return 'assets/logos/Zeagles.png';
      default:
        return '';
    }
  }

  static List<Map> teamList = [
    {'id': 1, 'name': 'Hit Squad', 'logo': 'assets/logos/HitSquad.png'},
    {'id': 2, 'name': 'Zorro Zebras', 'logo': 'assets/logos/ZorroZebras.png'},
    {
      'id': 3,
      'name': 'ZorroCyclones',
      'logo': 'assets/logos/ZorroCyclones.png'
    },
    {'id': 4, 'name': 'Zeagles', 'logo': 'assets/logos/Zeagles.png'}
  ];

  static showErrorDialog(BuildContext context, String msg) async {
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
