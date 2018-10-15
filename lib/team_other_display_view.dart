/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/styles.dart';
import 'package:ic_fantasy_football/player_disabled_drag_view.dart';

import 'package:ic_fantasy_football/model/team.dart';


class TeamOtherDisplayView extends StatefulWidget {

  final Team team;

  const TeamOtherDisplayView({
    Key key,
    @required this.team,
  })  : super(key: key);


  @override
  _TeamOtherDisplayViewState createState() => new _TeamOtherDisplayViewState();
}

class _TeamOtherDisplayViewState extends State<TeamOtherDisplayView> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.team.name),
        ),
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
                            child: Text("Points ${widget.team.points}", style: Styles.whiteText)),
                        Expanded(
                            flex: 1,
                            child: Text("This week ${widget.team.getCurrentWeeklyPoints()}", style: Styles.whiteText)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Image.asset("assets/pitch.jpg", fit: BoxFit.fitWidth, alignment: Alignment.topLeft,)
                            ),
                            Positioned.fill(
                                child: Image.asset("assets/bench.jpg", fit: BoxFit.fitWidth, alignment: Alignment.bottomLeft,)
                            ),
                          ]
                      )
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
                        children: List.generate(1, (index) => PlayerDisabledDragView(player: widget.team.players[0])),
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
                        children: List.generate(widget.team.defNum, (index) => PlayerDisabledDragView(player: widget.team.players[index+1])),
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
                        children: List.generate(widget.team.midNum, (index) => PlayerDisabledDragView(player: widget.team.players[index+widget.team.defNum+1])),
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
                        children: List.generate(widget.team.fwdNum, (index) => PlayerDisabledDragView(player: widget.team.players[index+widget.team.defNum+widget.team.midNum+1])),
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
                        children: List.generate(5, (index) => PlayerDisabledDragView(player: widget.team.players[11+index])),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                ],
              )
            ]
        )
    );
  }
}
