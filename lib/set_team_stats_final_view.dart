/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/model/team_stats.dart';
import 'package:ic_fantasy_football/controller/internet_async.dart';

class SetTeamStatsFinalView extends StatefulWidget {
  @override
  _SetTeamStatsFinalViewState createState() =>
      new _SetTeamStatsFinalViewState();
}

class _SetTeamStatsFinalViewState extends State<SetTeamStatsFinalView> {
  @override
  Widget build(BuildContext context) {
    Widget createPlayerSummary(Player player) {
      const double _ICON_HEIGHT = 18.0;

      List<Widget> motm = List<Widget>.generate(
          TeamStats.get().getStatPlayerCount(player, Stat.redCards),
          (_) => Text("MOTM"));

      List<Widget> goals = List<Widget>.generate(
          TeamStats.get().getStatPlayerCount(player, Stat.goals),
          (_) => Image.asset(
                "assets/football.png",
                height: _ICON_HEIGHT,
              ));

      List<Widget> ownGoals = List<Widget>.generate(
          TeamStats.get().getStatPlayerCount(player, Stat.ownGoals),
          (_) => Image.asset(
                "assets/football_red.png",
                height: _ICON_HEIGHT,
              ));

      List<Widget> assists = List<Widget>.generate(
          TeamStats.get().getStatPlayerCount(player, Stat.assists),
          (_) => Image.asset(
                "assets/football_red.png",
                height: _ICON_HEIGHT,
              ));

      List<Widget> yellowCards = List<Widget>.generate(
          TeamStats.get().getStatPlayerCount(player, Stat.yellowCards),
          (_) => Image.asset(
                "assets/yellow_card.png",
                height: _ICON_HEIGHT,
              ));

      List<Widget> redCards = List<Widget>.generate(
          TeamStats.get().getStatPlayerCount(player, Stat.redCards),
          (_) => Image.asset(
                "assets/red_card.png",
                height: _ICON_HEIGHT,
              ));

      List<Widget> row = [
        Text(player.fullName),
        ...motm,
        ...goals,
        ...ownGoals,
        ...assists,
        ...yellowCards,
        ...redCards
      ];

      return Wrap(
        spacing: 5,
        children: row,
      );
    }

    List<Player> _appearancePlayers =
        TeamStats.get().getSelectedPlayers(Stat.appearances);

    List<Player> _subPlayers = TeamStats.get().getSelectedPlayers(Stat.subs);

    return Scaffold(
        appBar: AppBar(
            title: Text("Set Team Stats Summary"),
            backgroundColor: Colors.blueAccent),
        body: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 30.0,
              child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Appearances",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                  itemCount: _appearancePlayers.length,
                  itemBuilder: (context, index) {
                    Player player = _appearancePlayers[index];
                    return ListTile(title: createPlayerSummary(player));
                  }),
            ),
            SizedBox(
              width: double.infinity,
              height: 30.0,
              child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      "Subs",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: _subPlayers.length,
                  itemBuilder: (context, index) {
                    Player player = _subPlayers[index];
                    return ListTile(
                      title: createPlayerSummary(player),
                    );
                  }),
            ),
            MaterialButton(
                height: 50.0,
                minWidth: double.infinity,
                color: Colors.blueAccent,
                splashColor: Colors.teal,
                textColor: Colors.white,
                child: Text("Submit Stats"),
                onPressed: () {
                  _showDialog(context);
                }),
          ],
        ));
  }

  // user defined function
  void _showDialog(BuildContext context) {
    Widget _submit = Text("Submit");
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Are you sure all the stats are correct?"),
          content: Text("This cannot be undone once submitted"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
                child: _submit,
                onPressed: () {
                  setState(
                    () {
                      _submit = FutureBuilder<void>(
                        future: InternetAsync().updatePlayerStats(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text("Submit");
                          }
                          // By default, show a loading spinner
                          return CircularProgressIndicator();
                        },
                      );
                    },
                  );
                }),
            FlatButton(
              child: Text("I want to recheck"),
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
