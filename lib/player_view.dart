// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github ;)

import 'package:flutter/material.dart';
import 'package:ic_fantasy_football/model/player.dart';
import 'package:ic_fantasy_football/model/team.dart';
import 'package:ic_fantasy_football/model/user.dart';

class PlayerView extends StatefulWidget {
  final Function updateState;
  final Player player;
  final int index;

  PlayerView({
    Key key,
    @required this.player,
    @required this.index,
    @required this.updateState
  })  : super(key: key);

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  Team team;

  @override
  void initState() {
    super.initState();
    team = User.get().team;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: DragTarget<List<dynamic>>(
        builder: (BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,) {
          final hovered = accepted.length > 0;
          return Container(
            color: hovered ? Colors.green : Color(0x00000000),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(widget.player.image, fit: BoxFit.fitHeight,),
                ),
                Container(
                  color: Colors.green,
                  child: Text(widget.player.firstName.substring(0,1) + ". " + widget.player.lastName, textAlign: TextAlign.center,),
                ),
                Container(
                  color: Colors.green,
                  child: Text(widget.player.points.toString() + "|" + widget.player.pointsWeek.toString(), textAlign: TextAlign.center),
                ),
              ],
            )
          );
        },
        onWillAccept: (value) {
          if (value[0].position == widget.player.position) return true;
          switch (widget.player.position) {
            case "GK": {
              return false;
            }
            break;
            case "DEF": {
              if (team.defNum <= 3) return false;
            }
            break;

            case "MID": {
              if (team.midNum <= 3) return false;
            }
            break;

            case "FWD": {
              if (team.fwdNum <= 2) return false;
            }
            break;
          }
          switch (value[0].position) {
            case "GK": {
              return false;
            }
            case "DEF": {
              if (team.defNum >= 5) return false;
            }
            break;

            case "MID": {
              if (team.midNum >= 5) return false;
            }
            break;

            case "FWD": {
              if (team.fwdNum >= 3) return false;
            }
            break;
          }
          return true;
        },
        onAccept: (value) {
          int insert = 0;
          //handles repositioning of players
          if (value[0].position != widget.player.position) {
            switch (value[0].position) {
              case "DEF":
                insert = team.defNum;
                team.defNum++;
                break;
              case "MID":
                insert = team.defNum + team.midNum;
                team.midNum++;
                break;
              case "FWD":
                insert = 10;
                team.fwdNum++;
                break;
            }
            switch (widget.player.position) {
              case "DEF":
                team.defNum--;
                break;
              case "MID":
                team.midNum--;
                break;
              case "FWD":
                team.fwdNum--;
                break;
            }
            team.shiftPlayersAndInsert(widget.index, insert, value[0]);
          } else {
            team.players[widget.index] = value[0];
          }
          team.players[value[1]] = widget.player;

          //need to redraw all effected elements
          widget.updateState();
          },
      ),
    );
  }
}