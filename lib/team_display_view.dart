// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/styles.dart';
import 'package:ic_fantasy_football/player_view.dart';
import 'package:ic_fantasy_football/sub_view.dart';
import 'package:ic_fantasy_football/controller/player_lab.dart';
import 'package:ic_fantasy_football/controller/internet_async.dart';

import 'package:ic_fantasy_football/model/user.dart';
import 'package:ic_fantasy_football/model/team.dart';


class TeamDisplayView extends StatefulWidget {
  @override
  _TeamDisplayViewState createState() => new _TeamDisplayViewState();
}

class _TeamDisplayViewState extends State<TeamDisplayView> {

  Team team = User.get().team;

  PlayerLab playerLab = PlayerLab.get();

  Widget saveChanges = Text("Press to save changes");


  @override
  Widget build(BuildContext context) {

    Function updateState = () {
      setState(() {
        team = User.get().team;
      });
    };

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                color: Colors.lightBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Text("Points 10", style: Styles.whiteText)),
                    Expanded(
                        flex: 1,
                        child: Text("This week 20", style: Styles.whiteText)),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.asset("assets/bench.jpg", fit: BoxFit.fitWidth, alignment: Alignment.bottomLeft,)
                    ),
                    Positioned.fill(
                        child: Image.asset("assets/pitch.jpg", fit: BoxFit.fitWidth, alignment: Alignment.topLeft,)
                    )
                  ]
                )
              ),
              new MaterialButton(
                  height: 50.0,
                  minWidth: double.infinity,
                  color: Colors.blueAccent,
                  splashColor: Colors.teal,
                  textColor: Colors.white,
                  child: saveChanges,
                  onPressed: () {
                    setState(() {
                      saveChanges = FutureBuilder(

                        future: InternetAsync().updateTeam(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Text("Press to save changes");
                          }

                          // By default, show a loading spinner
                          return CircularProgressIndicator();
                        },
                      );
                    });
                  }
              ),
            ],
          ),
          Column( //players
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container()
              ),
              Expanded(
                flex: 10,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(1, (index) => PlayerView(player: team.players[0], index: 0, updateState: updateState,)),
                )
              ),
              Expanded(
                flex: 1,
                child: Container()
              ),
              Expanded(
                flex: 10,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(team.defNum, (index) => PlayerView(player: team.players[index+1], index: index+1, updateState: updateState)),
                )
              ),
              Expanded(
                flex: 1,
                child: Container()
              ),
              Expanded(
                flex: 10,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(team.midNum, (index) => PlayerView(player: team.players[index+team.defNum+1], index: index+team.defNum+1, updateState: updateState)),
                )
              ),
              Expanded(
                flex: 1,
                child: Container()
              ),
              Expanded(
                flex: 10,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(team.fwdNum, (index) => PlayerView(player: team.players[index+team.defNum+team.midNum+1], index: index+team.defNum+team.midNum+1, updateState: updateState)),
                )
              ),
              Expanded(
                flex: 2,
                child: Container()
              ),
              Expanded(
                flex: 10,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) => SubView(player: team.players[11+index], index: 11+index)),
                )
              ),
              Expanded(
                flex: 4,
                child: Container()
              ),
            ],
          )
        ]
      )
    );
  }
}
