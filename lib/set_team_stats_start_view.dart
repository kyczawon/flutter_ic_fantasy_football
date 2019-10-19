/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/model/team_stats.dart';
import 'set_team_stats_view.dart';

class SetTeamStatsStartView extends StatefulWidget {
  @override
  _SetTeamStatsStartViewState createState() => _SetTeamStatsStartViewState();
}

class _SetTeamStatsStartViewState extends State<SetTeamStatsStartView> {
  final TeamStats ts = TeamStats.get();
  bool icScoreSet = false, opponentScoreSet = false, teamNumSet = false, opponentSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Set Team Stats"), backgroundColor: Colors.blueAccent),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("IC Score"),
                Container(
                  width: 50,
                  child: TextField(
                    decoration: new InputDecoration(
                        hintText: "score", fillColor: Colors.white),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      icScoreSet = true;
                      ts.ICScore = int.parse(value);
                    },
                  ),
                ),
                Text("Opponent Score"),
                Container(
                  width: 50,
                  child: TextField(
                    decoration: new InputDecoration(
                        hintText: "score", fillColor: Colors.white),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      opponentScoreSet = true;
                      ts.opponentScore = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("IC Team"),
                DropdownButton<int>(
                  value: teamNumSet ? ts.team : null,
                  items: <int>[1, 2, 3, 4, 5, 6, 7].map((int value) {
                    return new DropdownMenuItem<int>(
                      value: value,
                      child: new Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int value) {
                    teamNumSet = true;
                    ts.team = value;
                    setState(() {
                    });
                  },
                ),
                Text("Opponent"),
                Container(
                  width: 100,
                  child: TextField(
                    decoration: new InputDecoration(
                        hintText: "team name", fillColor: Colors.white),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      opponentSet = true;
                      ts.opponent = value;
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            MaterialButton(
                height: 50.0,
                minWidth: double.infinity,
                color: Colors.blueAccent,
                splashColor: Colors.teal,
                textColor: Colors.white,
                child: Text("Submit Stats"),
                onPressed: () {
                  if (icScoreSet && opponentScoreSet && teamNumSet && opponentSet) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return SetTeamStatsView();
                        }));
                  } else {
                    final snackBar = SnackBar(
                        content: Text("You need to set all fields"),
                        duration: Duration(seconds: 2));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                }),
          ],
        ));
  }
}
