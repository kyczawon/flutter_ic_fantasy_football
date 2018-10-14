/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/styles.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/model/team.dart';
import 'package:ic_fantasy_football/model/user.dart';
import 'package:ic_fantasy_football/controller/internet_async.dart';
import 'package:ic_fantasy_football/players_creation_details_view.dart';


class CreateTeamView extends StatefulWidget {

  final List<Player> selectedPlayers;

  CreateTeamView({
    Key key,
    players,
    selectedPlayers,
  })  : selectedPlayers = (selectedPlayers == null) ? new List<Player>.generate(16, (int index) => null) : selectedPlayers;

  @override
  _CreateTeamViewState createState() => _CreateTeamViewState();


}

class _CreateTeamViewState extends State<CreateTeamView> {

  final double _checkboxHeight = 30.0;
  double _startingBudget = 107.0;
  double _budget = 107.0;
  bool _everyTeam = false, _minThreeFreshers = false, _maxThreeSameTeam = true, _isTeamNameLong = false, _buttonEnabled = true;
  String _teamName = "";
  Widget _saveChanges = Text("Press to save changes");

  @override
  void initState() {
    Map<int,int> teamCount = new Map<int, int>();
    int fresherCount = 0;
    for (Player player in widget.selectedPlayers) {
        if (player != null) {
          _budget -= player.price;
          if (player.isFresher) fresherCount++;
          if (teamCount[player.team] == null) {
            teamCount[player.team] = 1;
          } else {
            teamCount[player.team]++;
            if (teamCount[player.team] > 3) _maxThreeSameTeam = false;
          }
        }
      }
    _minThreeFreshers = (fresherCount >= 3);
    _everyTeam = (teamCount.length >=7);
    super.initState();
  }

  emptyPlayer(int index) {
    Player player = widget.selectedPlayers[index];
    Widget playerView;

    if (player == null) {
      playerView = Image.asset("assets/shirt_blank.png", fit: BoxFit.fitHeight,);
    } else {
      playerView = Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(player.image, fit: BoxFit.fitHeight,),
          ),
          Container(
            color: Colors.green,
            child: Text(player.firstName.substring(0,1) + ". " + player.lastName, textAlign: TextAlign.center, softWrap: false, overflow: TextOverflow.fade,),
          ),
          Container(
            color: Colors.green,
            child: Text("£${player.price}m", textAlign: TextAlign.center),
          ),
        ],
      );
    }

    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return PlayersCreationDetailsView(selectedPlayers: widget.selectedPlayers, playerIndex: index,);})),
        child: Padding(padding: EdgeInsets.only(left: 3.0, right: 3.0), child:playerView,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("Create your team"),),
        body: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Image.asset("assets/pitch.jpg", fit: BoxFit.fitWidth, alignment: Alignment.topLeft,)
                            )
                          ]
                      )
                  ),
                ],
              ),
              Column( //players
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Padding(
                        padding: EdgeInsets.only(left: 40.0, right: 40.0), child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(2, (index) => emptyPlayer(index)),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) =>  emptyPlayer(index+2)),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) =>  emptyPlayer(index+7)),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 6,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(4, (index) =>  emptyPlayer(index+12)),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Container(
                    color: Styles.colorAccentDark,
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("Remaining Budget", style: Styles.budgetLabel,),
                              ),
                              Text("£${_budget}m", style: Styles.budgetLabel,)
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text("At least one player from every team:", style: Styles.checkboxLabel),
                            ),
                            Container(
                              height: _checkboxHeight,
                              child: Checkbox(
                                value: _everyTeam,
                                onChanged: (bool) => null,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text("At least two freshers:", style: Styles.checkboxLabel),
                            ),
                            Container(
                              height: _checkboxHeight,
                              child: Checkbox(
                                value: _minThreeFreshers,
                                onChanged: (bool) => null,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text("Max three players from same team:", style: Styles.checkboxLabel),
                            ),
                            Container(
                              height: _checkboxHeight,
                              child: Checkbox(
                                value: _maxThreeSameTeam,
                                onChanged: (bool) => null,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextField(
                                    onChanged: (string) {
                                      if (string.length >= 4) {
                                        _teamName = string;
                                        setState(() {
                                          _isTeamNameLong = true;
                                        });
                                      } else {
                                        setState(() {
                                          _isTeamNameLong = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Styles.colorBackgroundLight,
                                      filled: true,
                                      hintText: "Team Name",
                                    ),
                                  )
                              ),
                              Container(
                                height: _checkboxHeight,
                                child: Checkbox(
                                  value: _isTeamNameLong,
                                  onChanged: (bool) => null,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  ,
                  new MaterialButton(

                    height: 50.0,
                    minWidth: double.infinity,
                    color: Styles.colorButton,
                    splashColor: Colors.teal,
                    textColor: Colors.white,
                    child: _saveChanges,
                    onPressed: () {
                      if (_buttonEnabled) {
                        String message = "";

                        if (!_everyTeam) {
                          message +=
                          "You need at least one player from every team \n";
                        }
                        if (!_minThreeFreshers) {
                          message +=
                          "You need at least 3 freshers in your team \n";
                        }
                        if (!_maxThreeSameTeam) {
                          message +=
                          "You can have at most 3 players from the same team \n";
                        }
                        if (!_isTeamNameLong) {
                          message +=
                          "Your team name must be at least 4 characters long \n";
                        }
                        if (_budget < 0) {
                          message += "You can't exceed the budget \n";
                        }

                        if (message != "") {
                          final snackBar = SnackBar(
                              content: Text(message),
                              duration: Duration(seconds: 2)
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          setState(() {
                            _saveChanges = FutureBuilder(

                              future: InternetAsync().addTeam(context,
                                  Team.fromSelectedList(
                                      widget.selectedPlayers, _teamName, User
                                      .get()
                                      .username, _startingBudget - _budget)),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  _buttonEnabled = true;
                                  return Text("Press to save changes");
                                }
                                // By default, show a loading spinner and disable button
                                _buttonEnabled = false;
                                return CircularProgressIndicator();
                              },
                            );
                          });
                        }
                      }
                    }
                  ),

                ],
              ),
            ],
        )
      )
    );
  }

}
