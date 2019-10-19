/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/model/team_stats.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/set_team_stats_final_view.dart';

enum ButtonText { plus, minus }

class TeamStatsButtoned extends StatefulWidget {
  final Stat _currentStat;

  TeamStatsButtoned({
    Key key,
    Stat stat,
  })  : _currentStat = stat,
        super(key: key) {
    assert(_currentStat != null);
  }

  @override
  _TeamStatsButtonedState createState() => _TeamStatsButtonedState();
}

class _TeamStatsButtonedState extends State<TeamStatsButtoned> {
  //expected text is "+" or "-"
  MaterialButton getButton(String text, Player player) {
    return MaterialButton(
        onPressed: () {
          assert(text == "+" || text == "-");
          if (text == "+")
            TeamStats.get().addPlayer(player, widget._currentStat);
          else
            TeamStats.get().removePlayer(player, widget._currentStat);
          setState(() {});
        },
        child: Text(
          text,
          overflow: TextOverflow.fade,
          softWrap: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    TeamStats ts = TeamStats.get();
    List<Player> _players =
        ts.getAvailablePlayers(widget._currentStat);

    return Scaffold(
        appBar: new AppBar(
            title: new Text(ts.statAsString(widget._currentStat)),
            backgroundColor: Colors.blueAccent),
        body: Builder(
            builder: (context) => Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount: _players.length,
                          itemBuilder: (context, index) {
                            Player player = _players[index];
                            return ListTile(
                              title: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(player.fullName),
                                  ),
                                  getButton('+', player),
                                  Text(ts
                                      .getStatPlayerCount(
                                          player, widget._currentStat)
                                      .toString()),
                                  getButton('-', player),
                                ],
                              ),
                            );
                          }),
                    ),
                    new MaterialButton(
                        height: 50.0,
                        minWidth: double.infinity,
                        color: Colors.blueAccent,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: Text("Next"),
                        onPressed: () {
                          String message = "";
                          switch (widget._currentStat) {
                            case Stat.goals:
                              if (ts
                                      .getStatCount(widget._currentStat) >
                                  ts.ICScore) {
                                message =
                                    "There can't have been more goals scored than scoreline";
                              }
                              break;
                            case Stat.assists:
                              if (ts
                                      .getStatCount(widget._currentStat) >
                                  ts.ICScore) {
                                message =
                                    "There can't have been more assists than scoreline";
                              }
                              break;
                            case Stat.ownGoals:
                              if (ts
                                      .getStatCount(widget._currentStat) >
                                  ts.opponentScore) {
                                message =
                                    "There can't have been more own goals scored than scoreline";
                              }
                              break;
                            default:
                              message = "This state should not exist!!";
                          }

                          if (message != "") {
                            final snackBar = SnackBar(
                                content: Text(message),
                                duration: Duration(seconds: 2));
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              if (ts
                                  .isFinalButton(widget._currentStat)) {
                                return SetTeamStatsFinalView();
                              } else {
                                Stat nextStat =
                                ts.nextStat(widget._currentStat);
                                return TeamStatsButtoned(stat: nextStat);
                              }
                            }));
                          }
                        }),
                  ],
                )));
  }
}
